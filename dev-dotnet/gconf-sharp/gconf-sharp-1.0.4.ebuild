# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gconf-sharp/gconf-sharp-1.0.4.ebuild,v 1.1 2004/11/19 03:29:01 latexer Exp $

inherit gtk-sharp-component eutils

SLOT="1"
KEYWORDS="~x86"
IUSE=""

DEPEND="${DEPEND}
		>=dev-dotnet/gtk-sharp-1.0.4-r1
		>=gnome-base/gconf-2.0
		=dev-dotnet/glade-sharp-${PV}*
		=dev-dotnet/gnome-sharp-${PV}*
		=dev-dotnet/art-sharp-${PV}*"

GTK_SHARP_COMPONENT_BUILD="gnome"
GTK_SHARP_COMPONENT_BUILD_DEPS="art"

src_unpack() {
	gtk-sharp-component_src_unpack

	# Fix need as GConf.PropertyEditors references a locally built dll
	sed -i "s:${GTK_SHARP_LIB_DIR}/gconf-sharp.dll:../GConf/gconf-sharp.dll:" \
		${S}/gconf/GConf.PropertyEditors/Makefile.in
}
