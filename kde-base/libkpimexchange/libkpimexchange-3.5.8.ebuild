# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkpimexchange/libkpimexchange-3.5.8.ebuild,v 1.6 2008/01/31 15:28:05 ranger Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE PIM exchange library"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkcal)"

RDEPEND="${DEPEND}"

KMCOPYLIB="libkcal libkcal"
# libkcal is installed because a lot of headers are needed, but it don't have to be compiled
KMEXTRACTONLY="
	libkcal/"
KMCOMPILEONLY="
	libkcal/libical/src/libical/
	libkcal/libical/src/libicalss/"

src_compile() {
	kde-meta_src_compile myconf configure
	# generate "ical.h"
	cd "${S}/libkcal/libical/src/libical" && make ical.h
	# generate "icalss.h"
	cd "${S}/libkcal/libical/src/libicalss" && make icalss.h

	kde-meta_src_compile make
}
