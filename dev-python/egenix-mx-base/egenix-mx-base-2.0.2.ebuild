# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/egenix-mx-base/egenix-mx-base-2.0.2.ebuild,v 1.11 2002/12/15 10:44:18 bjb Exp $


S=${WORKDIR}/${P}
DESCRIPTION="egenix utils for Python."
SRC_URI="http://www.lemburg.com/files/python/${P}.tar.gz"
HOMEPAGE="http://www.egenix.com/"

DEPEND="virtual/python"
RDEPEND="${RDEPEND}"

SLOT="0"
KEYWORDS="x86 sparc alpha"
LICENSE="eGenixPublic"
#please note, there is also a possibility to buy a commercial license
#from egenix.com

src_compile() {
	python setup.py build || die
}

src_install() {
	python setup.py install --prefix=${D}/usr || die
}
