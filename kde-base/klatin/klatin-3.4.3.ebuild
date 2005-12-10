# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/klatin/klatin-3.4.3.ebuild,v 1.6 2005/12/10 05:53:41 chriswhite Exp $
KMNAME=kdeedu
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE: KLatin - a program to help revise Latin"
KEYWORDS="~alpha amd64 ppc ppc64 sparc x86"
IUSE=""
OLDDEPEND="~kde-base/libkdeedu-3.3.1"
DEPEND="
$(deprange 3.4.2 $MAXKDEVER kde-base/libkdeedu)"


KMEXTRACTONLY="libkdeedu/kdeeducore"
KMCOPYLIB="libkdeeducore libkdeedu/kdeeducore"

