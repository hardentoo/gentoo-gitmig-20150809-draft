# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-utils/gnome-utils-2.16.2.ebuild,v 1.4 2006/12/17 00:40:32 dertobi123 Exp $

inherit gnome2

DESCRIPTION="Utilities for the Gnome2 desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ~ppc64 ~sparc x86"
IUSE="hal ipv6"

RDEPEND=">=x11-libs/gtk+-2.8
	>=dev-libs/glib-2.9.1
	>=gnome-base/gnome-desktop-2.9.91
	>=gnome-base/libgnome-2.13.2
	>=gnome-base/libgnomeui-2.13.7
	>=gnome-base/libglade-2.3
	>=gnome-base/libbonoboui-2.1
	>=gnome-base/gnome-vfs-2.8.4
	>=gnome-base/gnome-panel-2.13.4
	>=gnome-base/libgnomeprint-2.8
	>=gnome-base/libgnomeprintui-2.8
	>=gnome-base/libgtop-2.12
	>=gnome-base/libgnomecanvas-2.10.2
	>=gnome-base/gconf-2
	sys-fs/e2fsprogs
	hal? ( >=sys-apps/hal-0.5 )"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.9"


DOCS="AUTHORS ChangeLog NEWS README THANKS"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable ipv6) $(use_enable hal)"
}
