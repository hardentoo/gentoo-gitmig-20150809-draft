# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/atk/atk-1.2.4.ebuild,v 1.4 2003/07/18 22:18:16 tester Exp $

inherit gnome2

IUSE="doc"
S=${WORKDIR}/${P}
DESCRIPTION="Gnome Accessibility Toolkit"
HOMEPAGE="http://developer.gnome.org/projects/gap/"

SLOT="1"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc ~alpha sparc hppa amd64"

RDEPEND=">=dev-libs/glib-2"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-0.9-r2 )
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS ChangeLog COPYING README* INSTALL NEWS"
