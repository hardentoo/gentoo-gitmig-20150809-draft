# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kaddressbook-plugins/kaddressbook-plugins-3.4.1.ebuild,v 1.5 2005/07/01 23:24:19 pylon Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA=kaddressbook-plugins/
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Plugins for KAB"
KEYWORDS="amd64 ppc ppc64 ~sparc x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/kaddressbook)"
OLDDEPEND="~kde-base/kaddressbook-$PV"
