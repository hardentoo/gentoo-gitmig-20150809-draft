# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/spe/spe-0.8.2.ebuild,v 1.3 2007/03/05 04:16:20 genone Exp $

inherit distutils eutils

MY_P="SPE-0.8.2.a-wx2.6.1.0"
DESCRIPTION="Python IDE with Blender support"
HOMEPAGE="http://www.stani.be/python/spe/blog/"
SRC_URI="http://download.berlios.de/python/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""
S=${WORKDIR}/${MY_P}

DEPEND=">=virtual/python-2.3
	app-arch/unzip"

RDEPEND=">=dev-python/wxpython-2.6.1.0
	>=dev-util/wxglade-0.3.2
	>=dev-python/pychecker-0.8.13
	${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	chmod -R go-w ${S}/*
}

src_install() {
	distutils_src_install
	distutils_python_version
	SITEPATH="/usr/lib/python${PYVER}/site-packages"

	dobin spe
	rm -rf "${D}${SITEPATH}/_spe/plugins/wxGlade"
	rm -rf "${D}${SITEPATH}/_spe/plugins/pychecker"
	ln -svf "../../wxglade" "${D}${SITEPATH}/_spe/plugins/wxGlade"
	dodir "${SITEPATH}/wxglade"
	touch "${D}${SITEPATH}/wxglade/__init__.py"
	ln -svf "../../pychecker" "${D}${SITEPATH}/_spe/plugins/pychecker"
}

pkg_postinst() {
	distutils_python_version
	SPEPATH="/usr/lib/python${PYVER}/site-packages"

	elog
	elog "To be able to use spe in blender, be sure that the path where spe is"
	elog "installed ($SPEPATH) is included in your PYTHONPATH"
	elog "environment variable. See the installation section in the manual for"
	elog "more information ($SPEPATH/_spe/doc/manual.pdf)."
	elog
}
