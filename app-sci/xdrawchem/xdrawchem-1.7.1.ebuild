# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/xdrawchem/xdrawchem-1.7.1.ebuild,v 1.4 2004/02/22 19:53:44 agriffis Exp $

DESCRIPTION="a molecular structure drawing program"
HOMEPAGE="http://www.prism.gatech.edu/~gte067k/${PN}"
SRC_URI="http://www.prism.gatech.edu/~gte067k/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE="qt"

DEPEND="qt? ( >=x11-libs/qt-3.1.0 )"

src_compile() {
	./configure --prefix=/usr || die
	emake -f Makefile INSTRING=/usr/share/xdrawchem || die
}

src_install() {
	dodir /usr/bin
	dobin xdrawchem/xdrawchem

	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins ring/*

	dodoc README.txt TODO.txt COPYRIGHT.txt HISTORY.txt
	dohtml doc/*
}
