# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdegames/libkdegames-3.4.0.ebuild,v 1.3 2005/03/25 00:52:53 weeve Exp $
KMNAME=kdegames
KM_MAKEFILESREV=1
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="library common to many KDE games"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE=""
DEPEND=""

