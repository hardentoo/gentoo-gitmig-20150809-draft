# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope-publisher/zope-publisher-3.12.0.ebuild,v 1.3 2010/01/22 19:22:35 ranger Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="The Zope publisher publishes Python objects on the web."
HOMEPAGE="http://pypi.python.org/pypi/zope.publisher"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-python/setuptools
	net-zope/zope-browser
	net-zope/zope-component
	net-zope/zope-configuration
	net-zope/zope-contenttype
	net-zope/zope-event
	net-zope/zope-exceptions
	net-zope/zope-i18n
	net-zope/zope-interface
	net-zope/zope-location
	net-zope/zope-proxy
	net-zope/zope-schema
	net-zope/zope-security"
DEPEND="${RDEPEND}
	app-arch/unzip"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="${PN/-//}"
DOCS="CHANGES.txt README.txt"
