# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysrt/pysrt-9999.ebuild,v 1.6 2015/04/08 08:04:57 mgorny Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1 git-r3

DESCRIPTION="Python library used to edit or create SubRip files"
HOMEPAGE="https://github.com/byroot/pysrt https://pypi.python.org/pypi/pysrt"
EGIT_REPO_URI="https://github.com/byroot/pysrt.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="
	dev-python/chardet[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[coverage(+),${PYTHON_USEDEP}] )
"

src_test() {
	DISTUTILS_NO_PARALLEL_BUILD=1 distutils-r1_src_test
}

python_test() {
	nosetests --with-coverage --cover-package=pysrt \
		|| die "Tests failed under ${EPYTHON}"
}
