# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/libwpd/libwpd-0.8.4.ebuild,v 1.3 2006/07/12 22:42:39 agriffis Exp $

inherit eutils

DESCRIPTION="WordPerfect Document import/export library"
HOMEPAGE="http://libwpd.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ia64 ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2
	>=gnome-extra/libgsf-1.6
	doc? ( app-doc/doxygen )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf $(use_with doc docs) || die
	emake || die
}

src_install() {
	einstall || die
	dodoc CHANGES COPYING CREDITS INSTALL README TODO
}
