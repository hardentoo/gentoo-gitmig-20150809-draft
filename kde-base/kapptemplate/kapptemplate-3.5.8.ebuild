# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kapptemplate/kapptemplate-3.5.8.ebuild,v 1.5 2008/01/31 15:29:41 ranger Exp $

ARTS_REQUIRED="no"
RESTRICT="binchecks strip"

KMNAME=kdesdk
MAXKDEVER=$PV
KM_DEPRANGE="3.5.0 $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KAppTemplate - A shell script that will create the necessary framework to develop various KDE applications."
KEYWORDS="~alpha amd64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

src_install() {
	kde-meta_src_install
	for f in ${KDEDIR}/share/apps/kapptemplate/admin/{bcheck,conf.change,config,detect-autoconf}.pl ; do
		fperms 755 ${f}
	done
}
