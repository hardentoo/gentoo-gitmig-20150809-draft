# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-fenet/lc-fenet-9999.ebuild,v 1.3 2014/07/14 05:44:01 pinkbyte Exp $

EAPI="5"

inherit leechcraft

DESCRIPTION="LeechCraft WM and compositor manager"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="
	~app-leechcraft/lc-core-${PV}
	dev-libs/qjson
"
RDEPEND="${DEPEND}"
