# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpilot/kpilot-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:37 danarmak Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KPilot - HotSync software for KDE"
KEYWORDS="~x86"
IUSE=""
DEPEND="app-pda/pilot-link
	dev-libs/libmal
$(deprange-dual $PV $MAXKDEVER kde-base/libkcal)
$(deprange-dual $PV $MAXKDEVER kde-base/libkdepim)
$(deprange-dual $PV $MAXKDEVER kde-base/kontact)"

KMCOPYLIB="
	libkcal libkcal
	libkdepim libkdepim
	libkpinterfaces kontact/interfaces"
# libkcal is installed because a lot of headers are needed, but it don't have to be compiled
KMEXTRACTONLY="
	libkcal/
	libkdepim libkdepim/
	kontact/interfaces/"
KMEXTRA="
	kfile-plugins/palm-databases
	kontact/plugins/kpilot/" # We add here the kontact's plugin instead of compiling it with kontact because it needs a lot of this programs deps.
