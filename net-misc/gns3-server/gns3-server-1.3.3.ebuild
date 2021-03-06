# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gns3-server/gns3-server-1.3.3.ebuild,v 1.1 2015/05/20 11:08:27 bman Exp $

EAPI=5

PYTHON_COMPAT=( python{3_3,3_4} )

inherit distutils-r1 eutils

DESCRIPTION="GNS3 server to asynchronously manage emulators"
HOMEPAGE="http://www.gns3.net/"
SRC_URI="https://github.com/GNS3/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=app-emulation/dynamips-0.2.12
		>=dev-python/aiohttp-0.14.4[${PYTHON_USEDEP}]
		>=dev-python/netifaces-0.8-r2[${PYTHON_USEDEP}]
		>=dev-python/jinja-2.7.3[${PYTHON_USEDEP}]
		>=dev-python/jsonschema-2.4.0[${PYTHON_USEDEP}]
		>=dev-python/libcloud-0.14.1[${PYTHON_USEDEP}]
		>=dev-python/raven-5.2.0[${PYTHON_USEDEP}]
		>=dev-python/pyzmq-14.3.1[${PYTHON_USEDEP}]
		>=www-servers/tornado-3.1.1[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

pkg_postinst() {
	ewarn "net-misc/gns3-server has several optional packages that must be merged manually for additional functionality."
	ewarn ""
	ewarn "The following is a list of packages that can be added:"
	ewarn "app-emulation/qemu, app-emulation/virtualbox, and net-analyzer/wireshark"
	ewarn ""
	ewarn "The following packages are currently unsupported:"
	ewarn "iouyap and vpcs"
}
