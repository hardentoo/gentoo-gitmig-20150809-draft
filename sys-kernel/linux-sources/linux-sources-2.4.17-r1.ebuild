# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-sources/linux-sources-2.4.17-r1.ebuild,v 1.1 2002/01/24 06:14:03 drobbins Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

#we use this next variable to avoid duplicating stuff on cvs
GFILESDIR=${PORTDIR}/sys-kernel/linux-sources/files
OKV=${PV}
KV=${PVR}
S=${WORKDIR}/linux-${KV}
S2=${WORKDIR}/linux-${KV}-extras

#This kernel includes XFS (CVS 16 Jan 2002) and mjb-2.4.18-r3 (which includes *lots* of good stuff))

DESCRIPTION="Linux kernel version ${KV} - full sources"
SRC_URI="http://www.de.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2  http://www.ibiblio.org/gentoo/distfiles/linux-gentoo-${KV}.patch.bz2"
PROVIDE="virtual/kernel"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/" 

if [ $PN = "linux-sources" ] && [ -z "`use build`" ]
then
	#console-tools is needed to solve the loadkeys fiasco.
	#binutils version needed to avoid Athlon/PIII/SSE assembler bugs.
	DEPEND=">=sys-devel/binutils-2.11.90.0.31 sys-apps/console-tools >=sys-apps/modutils-2.4.2 sys-devel/perl"
	RDEPEND=">=sys-libs/ncurses-5.2"
fi

[ -z "$LINUX_HOSTCFLAGS" ] && LINUX_HOSTCFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I${S}/include"

src_unpack() {
	mkdir ${S2}

	cd ${WORKDIR}
	unpack linux-${OKV}.tar.bz2
	mv linux linux-${KV} || die
	dodir /usr/src/linux-${KV}-extras
	if [ "$MOSIX" ]
	then
		cd ${S2}
		tar -xz --no-same-owner -f ${DISTDIR}/MOSIX-${MOSV}.tar.gz MOSIX-${MOSV}/patches.${OKV}
	fi
	cd ${S}
	cat ${DISTDIR}/linux-gentoo-${KV}.patch.bz2 | bzip2 -d | patch -p1 || die
	echo "Preparing for compilation..."
	
	#sometimes we have icky kernel symbols; this seems to get rid of them
	make mrproper || die

	#linux-sources needs to be fully configured, too.  This is the configuration for the default kernel
	cp ${S}/arch/i386/defconfig .config || die
	yes "" | make oldconfig
	echo "Ignore any errors from the yes command above."
    
	#fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R 0.0 *
	chmod -R a+r-w+X,u+w *

	# Gentoo Linux uses /boot, so fix 'make install' to work properly
	cd ${S}
	mv Makefile Makefile.orig
	sed -e 's:#export\tINSTALL_PATH:export\tINSTALL_PATH:' \
		Makefile.orig >Makefile || die # test, remove me if Makefile ok
	rm Makefile.orig
}
		
src_compile() {
	if [ "${PN}" = "linux-headers" ]
	then
		cd ${S}
		make include/linux/autoconf.h include/linux/version.h || die
	fi
}

src_install() {
	if [ "$PN" = "linux-sources" ]
	then
		dodir /usr/src
		cd ${S}
		echo ">>> Copying sources..."
		cp -ax ${WORKDIR}/* ${D}/usr/src
	elif [ "$PN" = "linux-headers" ]
	then
		dodir /usr/include/linux
		cp -ax ${S}/include/linux/* ${D}/usr/include/linux
		dodir /usr/include/asm
		cp -ax ${S}/include/asm-i386/* ${D}/usr/include/asm
	fi
	if [ -d ${D}/usr/src/linux-${KV} ]
	then
		cd ${D}/usr/src/linux-${KV}
		if [ -e .config ]
		then
			mv .config .config.eg
		fi
	fi
}

pkg_preinst() {
	if [ "$PN" = "linux-headers" ]
	then
		if [ -L ${ROOT}usr/include/linux ]
		then
			rm ${ROOT}usr/include/linux
		fi
		if [ -L ${ROOT}usr/include/asm ]
		then
			rm ${ROOT}usr/include/asm
		fi
	fi
}

pkg_postinst() {
	[ "$PN" = "linux-headers" ] && return
	rm -f ${ROOT}/usr/src/linux
	ln -sf linux-${KV} ${ROOT}/usr/src/linux
	#copy over our .config if one isn't already present
	cd ${ROOT}/usr/src/linux-${KV}
	if [ "${PN}" = "linux-sources" ] && [ -e .config.eg ] && [ ! -e .config ]
	then
		cp -a .config.eg .config
	fi
}
