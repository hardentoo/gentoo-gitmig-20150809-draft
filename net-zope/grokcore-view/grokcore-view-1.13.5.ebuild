# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/grokcore-view/grokcore-view-1.13.5.ebuild,v 1.1 2010/09/19 23:52:42 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Grok-like configuration for Zope browser pages"
HOMEPAGE="http://grok.zope.org/ http://pypi.python.org/pypi/grokcore.view"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-python/martian
	net-zope/grokcore-component
	net-zope/grokcore-security
	net-zope/zope-component
	net-zope/zope-browserresource
	net-zope/zope-interface
	net-zope/zope-login
	net-zope/zope-pagetemplate
	net-zope/zope-ptresource
	net-zope/zope-publisher
	net-zope/zope-security
	net-zope/zope-traversing"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODNAME="${PN/-//}"
