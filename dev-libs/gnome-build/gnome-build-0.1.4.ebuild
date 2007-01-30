# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gnome-build/gnome-build-0.1.4.ebuild,v 1.1 2007/01/30 16:47:56 compnerd Exp $

inherit gnome2

DESCRIPTION="The Gnome Build Framework"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=x11-libs/gtk+-2.4
	>=gnome-base/libglade-2.0
	>=gnome-base/libgnome-2.4
	>=gnome-base/libgnomeui-2.4
	>=gnome-base/libbonobo-2.4
	>=gnome-base/libbonoboui-2.4
	>=gnome-base/gnome-vfs-2.4
	>=dev-libs/libxml2-2.6
	>=dev-libs/gdl-0.7.0"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"

MAKEOPTS="-j1"
