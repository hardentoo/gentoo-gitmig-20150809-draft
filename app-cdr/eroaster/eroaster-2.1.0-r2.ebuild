# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/eroaster/eroaster-2.1.0-r2.ebuild,v 1.3 2003/09/16 10:09:16 aliz Exp $

IUSE="xmms encode oggvorbis"

S="${WORKDIR}/${P}"
DESCRIPTION="A graphical frontend for cdrecord and mkisofs written in gnome-python"
HOMEPAGE="http://eclipt.uni-klu.ac.at/eroaster.php"
SRC_URI="mirror://gentoo/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

# cdrecord and mkisofs are needed or configure fails
DEPEND=">=dev-lang/python-2.0
	=dev-python/gnome-python-1.4*
	app-cdr/cdrtools"

# xmms, lame and vorbis-tools are just runtime conveniences
# not a bulild dep.
RDEPEND="${DEPEND}
	app-cdr/bchunk
	xmms? ( media-sound/xmms )
	encode? ( media-sound/lame
		media-sound/sox )
	oggvorbis? ( media-sound/vorbis-tools )"

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/${P}-security.patch
}

src_install() {
	einstall \
		gnorbadir=${D}/usr/share/eroaster || die
}

