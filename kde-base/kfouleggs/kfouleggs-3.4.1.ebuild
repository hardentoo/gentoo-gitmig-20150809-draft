# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kfouleggs/kfouleggs-3.4.1.ebuild,v 1.5 2005/07/01 23:14:42 pylon Exp $
KMNAME=kdegames
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE games: KFoulEggs is an adaptation of the well-known (at least in Japan) PuyoPuyo game"
KEYWORDS="amd64 ppc ppc64 ~sparc x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkdegames)
$(deprange $PV $MAXKDEVER kde-base/libksirtet)"
OLDDEPEND="~kde-base/libkdegames-$PV ~kde-base/libksirtet-$PV"

KMEXTRACTONLY=libkdegames
KMCOMPILEONLY=libksirtet
KMCOPYLIB="libkdegames libkdegames"
