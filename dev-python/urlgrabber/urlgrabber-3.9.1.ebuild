# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/urlgrabber/urlgrabber-3.9.1.ebuild,v 1.5 2010/09/25 14:20:31 maekke Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Python module for downloading files"
HOMEPAGE="http://urlgrabber.baseurl.org"
SRC_URI="http://urlgrabber.baseurl.org/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~ppc64 x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-python/pycurl"
RDEPEND="${DEPEND}"
RESTRICT="test"
