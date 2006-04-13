# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/heavygear2/heavygear2-1.0b.ebuild,v 1.14 2006/04/13 19:46:45 wolf31o2 Exp $

inherit eutils games

IUSE="3dfx videos"
DESCRIPTION="Heavy Gear II - 3D first-person Mechanized Assault"
HOMEPAGE="http://www.activision.com/games/heavygearii/"
SRC_URI="mirror://lokigames/hg2/hg2-${PV}-cdrom-x86.run"

LICENSE="LOKI-EULA"
SLOT="0"
KEYWORDS="x86"
RESTRICT="strip"

DEPEND="games-util/loki_patch"
RDEPEND="${DEPEND}
	=media-libs/freetype-1*
	virtual/opengl"

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"
dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	games_pkg_setup
	cdrom_get_cds shell/movies/asteroid.mpg
	if use videos ; then
		ewarn "The installed game takes about 500MB of space!"
	else
		ewarn "The installed game takes about 400MB of space!"
	fi
}

src_unpack() {
	unpack_makeself
}

src_install() {
	dodir ${dir}
	einfo "Copying files... this may take a while..."
	exeinto ${dir}
	doexe ${CDROM_ROOT}/bin/x86/glibc-2.1/hg2
	insinto ${dir}
	use 3dfx && doins ${CDROM_ROOT}/bin/x86/glibc-2.1/LibMesaVoodooGL.so.1.2.030300

	doins ${CDROM_ROOT}/{README,icon.{bmp,xpm}}
	use videos && cp -r ${CDROM_ROOT}/shell ${Ddir}

	cd ${Ddir}
	use 3dfx && dosym LibMesaVoodooGL.so.1.2.030300 libGL.so.1

	tar xzf ${CDROM_ROOT}/data.tar.gz || die "uncompressing data"
	tar xzf ${CDROM_ROOT}/binaries.tar.gz || die "uncompressing binaries"

	cd ${S}
	loki_patch --verify patch.dat
	loki_patch patch.dat ${Ddir} >& /dev/null || die "patching"

	# now, since these files are coming off a cd, the times/sizes/md5sums wont
	# be different ... that means portage will try to unmerge some files (!)
	# we run touch on ${D} so as to make sure portage doesnt do any such thing
	find ${Ddir} -exec touch '{}' \;

	newicon ${CDROM_ROOT}/icon.xpm hg2.xpm
	games_make_wrapper hg2 ./hg2 "${dir}" "${dir}"
	make_desktop_entry hg2 "Heavy Gear II" hg2.xpm

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	if ! use videos ; then
		einfo "You will need to mount the Heavy Gear II CD to see the cut-scene videos."
		echo
	fi
	einfo "To play the game run:"
	einfo " hg2"
}
