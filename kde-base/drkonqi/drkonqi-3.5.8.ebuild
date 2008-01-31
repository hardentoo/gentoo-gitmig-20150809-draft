# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/drkonqi/drkonqi-3.5.8.ebuild,v 1.6 2008/01/31 15:27:30 ranger Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-02.tar.bz2"

DESCRIPTION="KDE crash handler gives the user feedback if a program crashed"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

RDEPEND="sys-devel/gdb"
