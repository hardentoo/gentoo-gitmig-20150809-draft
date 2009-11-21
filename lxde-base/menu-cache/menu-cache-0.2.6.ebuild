# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/menu-cache/menu-cache-0.2.6.ebuild,v 1.3 2009/11/21 18:32:49 nixnut Exp $

EAPI="1"

DESCRIPTION="A library creating and utilizing caches to speed up freedesktop.org application menus"
HOMEPAGE="http://lxde.sourceforge.net/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.16.0:2"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README || die "dodoc failed"
}
