# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konqueror-dirfilter/konqueror-dirfilter-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:35 danarmak Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="konq-plugins/dirfilter"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="konqueror file manager directory filter plugin"
KEYWORDS="~x86"
IUSE=""
DEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/konqueror)
$(deprange-dual $PV $MAXKDEVER kde-base/kdeaddons-docs-konq-plugins)"
OLDDEPEND="~kde-base/konqueror-$PV ~kde-base/kdeaddons-docs-konq-plugins-$PV"
