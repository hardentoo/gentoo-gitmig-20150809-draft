# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/units/units-1.88.ebuild,v 1.4 2010/04/13 18:33:39 armin76 Exp $

EAPI="2"

inherit eutils

DESCRIPTION="unit conversion program"
SRC_URI="http://ftp.gnu.org/gnu/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/units/units.html"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
KEYWORDS="alpha ~amd64 hppa ppc sparc x86"

DEPEND=">=sys-libs/readline-4.1-r2
	>=sys-libs/ncurses-5.2-r3"

src_configure() {
	econf --datadir=/usr/share/${PN} || die "econf failed"
}

src_install() {
	einstall datadir="${D}"/usr/share/${PN} || die "emake install failed"
	dodoc ChangeLog NEWS README
}
