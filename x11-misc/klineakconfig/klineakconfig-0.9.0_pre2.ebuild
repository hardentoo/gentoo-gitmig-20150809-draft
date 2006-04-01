# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/klineakconfig/klineakconfig-0.9.0_pre2.ebuild,v 1.2 2006/04/01 11:26:20 genstef Exp $

inherit kde

MY_P=${P/_/-}

DESCRIPTION="LinEAK KDE configuration frontend"
HOMEPAGE="http://lineak.sourceforge.net/"
SRC_URI="mirror://sourceforge/lineak/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="x11-misc/lineakd
	kde-base/arts"

S="${WORKDIR}/${MY_P}"

need-kde 3.4
