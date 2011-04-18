# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/itcl/itcl-3.3-r1.ebuild,v 1.7 2011/04/18 06:20:41 jlec Exp $

inherit eutils

MY_P="${PN}${PV}"
DESCRIPTION="Object Oriented Enhancements for Tcl/Tk"
HOMEPAGE="http://incrtcl.sourceforge.net/"
SRC_URI="mirror://sourceforge/incrtcl/${MY_P}.tar.gz"

IUSE=""
SLOT="0"
LICENSE="BSD"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"

DEPEND="dev-lang/tcl"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "s/relid'/relid/" configure tclconfig/tcl.m4 || die
}

src_compile() {
	econf
	emake CFLAGS_DEFAULT="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc CHANGES ChangeLog INCOMPATIBLE README TODO
}
