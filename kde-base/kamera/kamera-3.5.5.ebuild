# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kamera/kamera-3.5.5.ebuild,v 1.7 2006/12/06 13:52:18 kloeri Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE digital camera manager"
KEYWORDS="alpha amd64 ~ia64 ppc ppc64 sparc x86"
IUSE=""
DEPEND="media-libs/libgphoto2"

RDEPEND="${DEPEND}"

