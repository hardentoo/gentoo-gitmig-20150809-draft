# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/diasce/diasce-1.2.ebuild,v 1.1 2002/11/07 18:55:50 foser Exp $

P=${PN}2-${PV}
S=${WORKDIR}/${P}
IUSE=""
DESCRIPTION="The C/C++ Code editor for Gnome"
SRC_URI="http://diasce.es.gnome.org/downloads/${P}.tar.gz"
HOMEPAGE="http://diasce.es.gnome.org"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~sparc64"

RDEPEND=">=dev-libs/libxml2-2.4
	>=x11-libs/gtk+-2
	>=dev-libs/glib-2
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libbonobo-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/bonobo-activation-1
	>=gnome-base/gnome-vfs-2
	>=gnome-base/gconf-1.2
	>=gnome-base/libgnomecanvas-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf=""

	use nls || myconf="${myconf} --disable-nls"

	econf ${myconf} || die "./configure failed"
	emake || die "emake failed"
}

src_install () {
	einstall || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}

