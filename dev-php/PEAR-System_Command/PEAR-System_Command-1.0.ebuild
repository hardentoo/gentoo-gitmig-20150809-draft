# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-System_Command/PEAR-System_Command-1.0.ebuild,v 1.6 2004/06/25 01:21:13 agriffis Exp $

MY_P=${PN/PEAR-//}-${PV}
DESCRIPTION="PEAR::System_Command is a commandline execution interface"
HOMEPAGE="http://pear.php.net/package-info.php?pacid=74"
SRC_URI="http://pear.php.net/get/${MY_P}.tgz"
LICENSE="PHP"
SLOT="0"
# Afaik, anything that runs php will run this...
KEYWORDS="x86 ppc sparc"
DEPEND="virtual/php"
IUSE=""
S=${WORKDIR}/${MY_P}

src_install () {
	insinto /usr/lib/php/
	doins Command.php
}
