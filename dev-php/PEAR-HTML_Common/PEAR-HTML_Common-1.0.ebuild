# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTML_Common/PEAR-HTML_Common-1.0.ebuild,v 1.6 2004/04/12 17:22:12 aliz Exp $

MY_P=${PN/PEAR-//}-${PV}
DESCRIPTION="base class for other HTML classes"
HOMEPAGE="http://pear.php.net/package-info.php?pacid=69"
SRC_URI="http://pear.php.net/get/${MY_P}.tgz"
IUSE=""
LICENSE="PHP"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND="virtual/php"

src_install() {
	insinto /usr/lib/php/HTML
	doins Common.php
}
