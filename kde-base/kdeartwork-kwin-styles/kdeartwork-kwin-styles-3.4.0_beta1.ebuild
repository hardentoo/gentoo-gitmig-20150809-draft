# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-kwin-styles/kdeartwork-kwin-styles-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:29 danarmak Exp $

KMMODULE=kwin-styles
KMNAME=kdeartwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Window styles for kde"
KEYWORDS="~x86"
IUSE=""
OLDDEPEND="~kde-base/kwin-$PV"
DEPEND="
$(deprange-dual $PV $MAXKDEVER kde-base/kwin)"

