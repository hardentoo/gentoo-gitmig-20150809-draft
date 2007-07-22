# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmemmon/wmmemmon-1.0.1.ebuild,v 1.14 2007/07/22 04:52:21 dberkholz Exp $

IUSE=""
DESCRIPTION="A program to monitor memory/swap usages."
SRC_URI="http://seiichisato.jp/dockapps/src/${P}.tar.gz"
HOMEPAGE="http://seiichisato.jp/dockapps/"

LICENSE="GPL-2"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
SLOT="0"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXt
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

src_install () {

	einstall || die "make install failed"

	doman doc/wmmemmon.1
	dodoc AUTHORS ChangeLog THANKS TODO README
	dobin src/wmmemmon

}
