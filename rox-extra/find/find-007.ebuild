# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/find/find-007.ebuild,v 1.1 2006/09/27 22:19:36 lack Exp $

inherit rox

MY_PN="Find"
DESCRIPTION="Find - A file Finder utility for ROX by Ken Hayber."
HOMEPAGE="http://www.hayber.us/rox/Find"
SRC_URI="http://www.hayber.us/rox/find/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

ROX_LIB_VER=2.0.0

APPNAME=${MY_PN}
S=${WORKDIR}

