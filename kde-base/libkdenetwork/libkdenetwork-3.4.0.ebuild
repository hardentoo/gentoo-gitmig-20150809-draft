# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdenetwork/libkdenetwork-3.4.0.ebuild,v 1.3 2005/03/25 01:03:30 weeve Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="library common to many KDE network apps"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE=""
DEPEND=">=app-crypt/gpgme-0.4.0"
