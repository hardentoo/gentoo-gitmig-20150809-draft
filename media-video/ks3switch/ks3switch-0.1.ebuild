# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ks3switch/ks3switch-0.1.ebuild,v 1.2 2002/10/04 05:55:59 vapier Exp $
inherit kde-base

need-kde 3

DESCRIPTION="GUI for s3switch"
SRC_URI="http://www.bochatay.net/francois/${P}.tar.gz"
HOMEPAGE="http://www.bochatay.net/francois/ks3switch.html"

LICENSE="GPL-2"
KEYWORDS="x86"

newdepend "sys-apps/s3switch"
