# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/nepomuk/nepomuk-4.2.1.ebuild,v 1.4 2009/04/11 05:49:56 jer Exp $

EAPI="2"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="Nepomuk KDE4 client"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	|| (
		dev-libs/soprano[clucene,redland]
		dev-libs/soprano[clucene,java]
	)
	>=kde-base/kdelibs-${PV}:${SLOT}[kdeprefix=,semantic-desktop]
"
RDEPEND="${DEPEND}"
