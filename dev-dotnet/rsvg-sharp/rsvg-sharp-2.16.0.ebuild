# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/rsvg-sharp/rsvg-sharp-2.16.0.ebuild,v 1.1 2006/09/07 05:31:07 latexer Exp $

GTK_SHARP_TARBALL_PREFIX="gnome-sharp"
GTK_SHARP_REQUIRED_VERSION="2.10"

inherit gtk-sharp-component

SLOT="2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="${DEPEND}
		=dev-dotnet/art-sharp-${PV}*
		>=gnome-base/librsvg-2.0.1"

GTK_SHARP_COMPONENT_SLOT="2"
GTK_SHARP_COMPONENT_SLOT_DEC="-2.0"
GTK_SHARP_COMPONENT_BUILD_DEPS="art"
