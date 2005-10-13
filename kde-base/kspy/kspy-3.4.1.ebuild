# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kspy/kspy-3.4.1.ebuild,v 1.7 2005/10/13 00:10:05 danarmak Exp $

KMNAME=kdesdk
MAXKDEVER=3.4.3
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kspy - an utility intended to help developers examine the internal state of a Qt/KDE application"
KEYWORDS="amd64 ~ppc ppc64 sparc x86"
IUSE=""