# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-mpd/python-mpd-0.2.1.ebuild,v 1.7 2010/12/15 11:29:39 angelos Exp $

EAPI="3"
PYTHON_DEPEND="2:2.4"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python MPD client library"
HOMEPAGE="http://jatreuman.indefero.net/p/python-mpd/"
SRC_URI="mirror://pypi/p/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="amd64 ~ppc ~ppc64 sparc x86"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND=""

DOCS="CHANGES.txt README.txt TODO.txt doc/commands.txt"
