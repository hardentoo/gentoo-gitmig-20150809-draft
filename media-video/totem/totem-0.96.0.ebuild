# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/totem/totem-0.96.0.ebuild,v 1.3 2003/04/14 22:27:54 foser Exp $

inherit gnome2 eutils

IUSE=""
DESCRIPTION="Totem is simple movie player for the Gnome2 desktop based on xine"
HOMEPAGE="http://www.hadess.net/totem.php3"

SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"

RDEPEND=">=dev-libs/glib-2.1
	>=x11-libs/gtk+-2
	>=gnome-base/libgnomeui-2.1.1
	>=gnome-base/gnome-vfs-2.2
	>=gnome-base/libglade-2
	>=media-libs/xine-lib-1_beta9"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.20
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS ChangeLog COPYING*  README* INSTALL NEWS"

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}-thumbnailer_thread_fix.patch
}
