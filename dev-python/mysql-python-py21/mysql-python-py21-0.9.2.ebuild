# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mysql-python-py21/mysql-python-py21-0.9.2.ebuild,v 1.8 2004/05/04 11:56:14 kloeri Exp $

PYTHON_SLOT_VERSION="2.1"

inherit distutils

S="${WORKDIR}/MySQL-python-${PV}"

DESCRIPTION="MySQL Module for python"
HOMEPAGE="http://sourceforge.net/projects/mysql-python/"
SRC_URI="mirror://sourceforge/mysql-python/MySQL-python-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="virtual/glibc
	>=dev-db/mysql-3.22.19"

src_install() {
	distutils_src_install
	dohtml doc/*
}
