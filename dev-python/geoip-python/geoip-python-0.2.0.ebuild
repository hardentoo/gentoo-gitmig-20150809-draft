# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/geoip-python/geoip-python-0.2.0.ebuild,v 1.5 2004/06/11 13:33:51 kugelfang Exp $

inherit distutils

MY_P=${P/geoip-python/GeoIP-Python}
DESCRIPTION="Python Bindings for GeoIP"
HOMEPAGE="http://www.maxmind.com/app/python"
SRC_URI="http://www.maxmind.com/download/geoip/api/python/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc ~amd64"
IUSE=""

DEPEND=">=dev-libs/geoip-1.2.1
	virtual/python"

S=${WORKDIR}/${MY_P}
