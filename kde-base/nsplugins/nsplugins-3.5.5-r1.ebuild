# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/nsplugins/nsplugins-3.5.5-r1.ebuild,v 1.1 2006/11/22 18:56:25 flameeyes Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-03.tar.bz2"

DESCRIPTION="Netscape plugins support for Konqueror."
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

PATCHES="${FILESDIR}/${P}-npapi-64bit.patch"

src_unpack() {
	kde-meta_src_unpack
	sed -i -e "s:SUBDIRS = viewer test:SUBDIRS = viewer:" ${S}/nsplugins/Makefile.am || die "sed failed"
}