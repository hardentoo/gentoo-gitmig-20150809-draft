# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/galeon/galeon-1.3.20.ebuild,v 1.1 2005/03/27 17:00:27 hanno Exp $

inherit gnome2 debug libtool eutils

DESCRIPTION="A GNOME Web browser based on gecko (mozilla's rendering engine)"
HOMEPAGE="http://galeon.sourceforge.net"
SRC_URI="mirror://sourceforge/galeon/${P}.tar.bz2"

LICENSE="GPL-2"
IUSE="firefox"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~amd64 ~ia64"
SLOT="0"

S=${WORKDIR}/${P}

RDEPEND="virtual/x11
	!firefox? ( >=www-client/mozilla-1.7.6-r1 )
	firefox? ( >=www-client/mozilla-firefox-1.0.2-r1 )
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2.4.0
	>=dev-libs/libxml2-2.6.6
	>=gnome-base/gconf-2.3.2
	>=gnome-base/orbit-2
	>=gnome-base/libbonobo-2
	>=gnome-base/libbonoboui-2.1.1
	>=gnome-base/libgnomeui-2.5.2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libglade-2.3.1
	app-text/scrollkeeper"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.30
	>=sys-devel/gettext-0.11"

src_compile() {
	use firefox && myconf="--with-mozilla=firefox"
	use firefox || myconf="--with-mozilla=mozilla"

	econf ${myconf} || die "configure failed"
	make || die "compile failed"
}

DOCS="AUTHORS COPYING COPYING.README ChangeLog FAQ INSTALL README README.ExtraPrefs THANKS TODO NEWS"
