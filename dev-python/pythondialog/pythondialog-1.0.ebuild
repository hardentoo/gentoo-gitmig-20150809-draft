# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pythondialog/pythondialog-1.0.ebuild,v 1.6 2004/05/04 12:29:12 kloeri Exp $

inherit eutils distutils
EPATCH_SOURCE="${FILESDIR}"

DESCRIPTION="A Python module for making simple text/console-mode user interfaces."
HOMEPAGE="http://pythondialog.sourceforge.net/"
SRC_URI="mirror://sourceforge/pythondialog/dialog.py"

SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
LICENSE="LGPL-2"
IUSE=""

DEPEND="virtual/python
	dev-util/dialog"

src_unpack() {
	mkdir "${S}"
	cp "${DISTDIR}/dialog.py" "${S}"
	cd "${S}"
	epatch
	mv setup.py setup.py.orig
	sed -e "s:__version__:${PV}:g" setup.py.orig > setup.py
	rm setup.py.orig
}

