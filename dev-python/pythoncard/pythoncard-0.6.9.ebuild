# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pythoncard/pythoncard-0.6.9.ebuild,v 1.9 2004/05/04 12:28:14 kloeri Exp $

DESCRIPTION="Cross-platform GUI construction kit for python"
HOMEPAGE="http://pythoncard.sourceforge.net/index.html"
SRC_URI="mirror://sourceforge/pythoncard/PythonCardPrototype-${PV}.tar.gz"

LICENSE="PYTHON"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/python
	>=dev-python/wxPython-2.3.2.1-r2"

S=${WORKDIR}/PythonCardPrototype-${PV}

src_compile() {
	python setup.py build || die
}

src_install() {
	python setup.py install --prefix=${D}/usr || die "Install Failed"
	dodoc README.txt README_StyleEditor.txt
}
