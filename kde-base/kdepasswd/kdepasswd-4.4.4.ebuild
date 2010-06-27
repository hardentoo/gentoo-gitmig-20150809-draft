# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepasswd/kdepasswd-4.4.4.ebuild,v 1.4 2010/06/27 18:18:27 fauli Exp $

EAPI="3"

KMNAME="kdebase-apps"
inherit kde4-meta

DESCRIPTION="KDE GUI for passwd"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

DEPEND="
	$(add_kdebase_dep libkonq)
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kdesu)
"

KMLOADLIBS="libkonq"
