# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/nsplugins/nsplugins-3.5.0.ebuild,v 1.1 2005/11/22 22:14:16 danarmak Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Netscape plugins support for konqueror"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""


