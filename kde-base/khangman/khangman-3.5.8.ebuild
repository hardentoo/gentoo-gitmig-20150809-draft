# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/khangman/khangman-3.5.8.ebuild,v 1.6 2008/01/31 15:31:27 ranger Exp $
KMNAME=kdeedu
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Classical hangman game for KDE"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
DEPEND="$(deprange 3.5.7 $MAXKDEVER kde-base/libkdeedu)"

RDEPEND="${DEPEND}"

KMEXTRACTONLY="libkdeedu/kdeeducore"
KMCOPYLIB="libkdeeducore libkdeedu/kdeeducore"
