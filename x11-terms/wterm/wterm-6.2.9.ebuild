# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/wterm/wterm-6.2.9.ebuild,v 1.7 2004/06/24 23:23:08 agriffis Exp $

DESCRIPTION="A fork of rxvt patched for fast transparency and a NeXT scrollbar"
HOMEPAGE="http://largo.windowmaker.org/files.php#wterm"
SRC_URI="http://largo.windowmaker.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND="virtual/x11
	>=x11-wm/windowmaker-0.80.1"

S="${WORKDIR}/${P}"

src_compile() {

	local myconf

	myconf="--enable-menubar --enable-graphics"

	econf ${myconf} || die "configure failed"

	emake || die "parallel make failed"

}

src_install() {

	einstall || die "make install failed"

}
