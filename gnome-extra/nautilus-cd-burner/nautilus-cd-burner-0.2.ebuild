# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-cd-burner/nautilus-cd-burner-0.2.ebuild,v 1.4 2003/04/19 01:39:38 lu_zero Exp $

inherit gnome2 debug

IUSE=""
S=${WORKDIR}/${P}
DESCRIPTION="CDR plugin for Nautilus"
#SRC_URI="http://ftp.gnome.org/pub/GNOME/desktop/2.1/2.1.2/sources/${P}.tar.bz2"
HOMEPAGE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=gnome-base/nautilus-2.1
	 >=gnome-base/gnome-vfs-2.1.3"

DEPEND=">=dev-util/intltool-0.18
	>=dev-util/pkgconfig-0.12.0
	${RDEPEND}"


DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS README"


