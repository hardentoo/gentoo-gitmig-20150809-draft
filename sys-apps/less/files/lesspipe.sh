#!/bin/bash
# 
# Preprocessor for 'less'. Used when this environment variable is set:
# LESSOPEN="|lesspipe.sh %s"

trap 'exit 0' PIPE

guesscompress() {
	case "$1" in
		*.gz)  echo "gunzip -c" ;;
		*.bz2) echo "bunzip2 -c" ;;
		*)     echo "cat" ;;
	esac
}

lesspipe_file() {
	local out=$(file -L -- "$1")
	case ${out} in
		*" ar archive"*)    lesspipe "$1" ".a" ;;
		*" CAB-Installer"*) lesspipe "$1" ".cab" ;;
		*" troff "*)        lesspipe "$1" ".man" ;;
		*" shared object"*) lesspipe "$1" ".so" ;;
		*" Zip archive"*)   lesspipe "$1" ".zip" ;;
		*" ELF "*)          readelf -a -- "$1" ;;
	esac
}

lesspipe() {
	local DECOMPRESSOR=""
	local match=$2
	[[ -z ${match} ]] && match=$1

	case "$match" in

	### Doc files ###
	*.[0-9n]|*.man|\
	*.[0-9n].bz2|*.man.bz2|\
	*.[0-9n].gz|*.man.gz)
		DECOMPRESSOR=$(guesscompress "$match")
		if [[ $($DECOMPRESSOR -- "$1" | file -) == *troff* ]] ; then
			# Need to make sure we pass path to man or it will try 
			# to locate "$1" in the man search paths
			if [[ $1 == /* ]] ; then
				man -- "$1"
			else
				man -- "./$1"
			fi
		else
			# We could have matched a library (libc.so.6), so let
			# `file` figure out what the hell this thing is
			case "$match" in
				*.man.gz|*.man.bz2)  $DECOMPRESSOR -- "$1";;
				*)                   lesspipe_file "$1";;
			esac
		fi
		;;
	*.dvi)      dvi2tty "$1" ;;
	*.ps|*.pdf) ps2ascii "$1" || pstotext "$1" ;;
	*.doc)      antiword "$1" ;;
	*.rtf)      unrtf --nopict --text "$1" ;;

	### URLs ###
	ftp://*|http://*|*.htm|*.html)
		for b in links2 links lynx ; do
			${b} -dump "$1" && exit 0
		done
		html2text -style pretty "$1"
		;;

	### Tar files ###
	*.tar)                  tar tvvf "$1" ;;
	*.tar.bz2|*.tbz2|*.tbz) tar tjvvf "$1" ;;
	*.tar.gz|*.tgz|*.tar.z) tar tzvvf "$1" ;;

	### Misc archives ###
	*.bz2)        bzip2 -dc -- "$1" ;;
	*.gz|*.z)     gzip -dc -- "$1"  ;;
	*.zip)        unzip -l "$1" ;;
	*.rpm)        rpm -qpivl --changelog -- "$1" ;;
	*.cpi|*.cpio) cpio -itv < "$1" ;;
	*.rar)        unrar l -- "$1" ;;
	*.ace)        unace l -- "$1" ;;
	*.arj)        unarj l -- "$1" ;;
	*.cab)        cabextract -l -- "$1" ;;
	*.lzh)        lha v "$1" ;;
	*.zoo)        zoo -list "$1" ;;
	*.7z)         7z l -- "$1" ;;
	*.a)          ar tv "$1" ;;
	*.so)         readelf -h -d -s -- "$1" ;;
	*.deb)
		if type -p dpkg > /dev/null ; then
			dpkg -I "$1"
			dpkg -c "$1"
		else
			ar tv "$1"
			ar p "$1" data.tar.gz | tar tzvvf -
		fi
		;;

	### Media ###
	*.bmp|*.gif|*.jpeg|*.jpg|*.pcd|*.pcx|*.png|*.ppm|*.tga|*.tiff|*.tif)
		identify "$1" || file -L -- "$1"
		;;
	*.avi|*.mpeg|*.mpg|*.mov|*.qt|*.wmv|*.asf|*.rm|*.ram)
		midentify "$1" || file -L -- "$1"
		;;
	*.mp3)        mp3info "$1" || id3info "$1" ;;
	*.ogg)        ogginfo "$1" ;;
	*.flac)       metaflac --list "$1" ;;
	*.iso)        isoinfo -d -i "$1" ; isoinfo -l -i "$1" ;;
	*.bin|*.cue)  cd-info --no-header --no-device-info "$1" ;;

	### Source code ###
	*.awk|*.java|*.js|*.m4|*.pl|*.sh|\
	*.[ch]|*.[ch]pp|*.[ch]xx|*.cc|*.hh|*.[sS]|\
	*.patch)
		# Only colorize if we know less will handle raw codes
		for opt in ${LESS} ; do
			if [[ ${opt} == "-r" || ${opt} == "-R" ]] ; then
				code2color "$1"
				break
			fi
		done
		;;

# May not be such a good idea :)
#	### Device nodes ###
#	/dev/[hs]d[a-z]*)
#		fdisk -l "${1:0:8}"
#		[[ $1 == *hd* ]] && hdparm -I "${1:0:8}"
#		;;

	### Everything else ###
	*)
		# Sanity check
		[[ ${recur} == 2 ]] && exit 0

		# Maybe we didn't match due to case issues ...
		if [[ ${recur} == 0 ]] ; then
			recur=1
			lesspipe "$1" "$(echo $1 | tr '[:upper:]' '[:lower:]')"

		# Maybe we didn't match because the file is named weird ...
		else
			recur=2
			lesspipe_file "$1"
		fi

		exit 0
		;;
	esac
}

if [[ -d $1 ]] ; then
	ls -alF -- "$1"
else
	recur=0
	lesspipe "$1" 2> /dev/null
fi
