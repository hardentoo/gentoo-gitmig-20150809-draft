# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gail/gail-1.6.6.ebuild,v 1.11 2005/01/08 23:24:22 slarti Exp $

inherit gnome2

DESCRIPTION="Accessibility support for Gtk+ and libgnomecanvas"
HOMEPAGE="http://developer.gnome.org/projects/gap"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc alpha sparc hppa amd64 arm ia64 mips ppc64"
IUSE=""

USE_DESTDIR="1"

RDEPEND=">=x11-libs/gtk+-2.3.5
	>=dev-libs/atk-1.5
	>=gnome-base/libgnomecanvas-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"
