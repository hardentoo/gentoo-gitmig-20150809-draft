# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/gnustep-back-art/gnustep-back-art-0.9.4-r1.ebuild,v 1.6 2006/01/29 15:47:02 blubb Exp $

inherit gnustep

S=${WORKDIR}/gnustep-back-${PV}

DESCRIPTION="libart_lgpl back-end component for the GNUstep GUI Library."

HOMEPAGE="http://www.gnustep.org"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/gnustep-back-${PV}.tar.gz
		mirror://gentoo/${P}-ft219-backport.patch.bz2"
KEYWORDS="ppc x86 amd64 sparc ~alpha"
SLOT="0"
LICENSE="LGPL-2.1"

PROVIDE="virtual/gnustep-back"

IUSE="opengl xim doc"
DEPEND="${GNUSTEP_GUI_DEPEND}
	~gnustep-base/gnustep-gui-0.9.4
	virtual/xft
	~media-libs/freetype-2.1.9
	opengl? ( virtual/opengl virtual/glu )
	gnustep-libs/artresources
	>=gnustep-base/mknfonts-0.5
	>=media-libs/libart_lgpl-2.3"
RDEPEND="${DEPEND}
	${DOC_RDEPEND}"

egnustep_install_domain "System"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${P}-ft219-backport.patch
}

src_compile() {
	egnustep_env

	use opengl && myconf="--enable-glx"
	myconf="$myconf `use_enable xim`"
	myconf="$myconf --enable-server=x11"
	myconf="$myconf --enable-graphics=art --with-name=art"
	econf $myconf || die "configure failed"

	egnustep_make
}

