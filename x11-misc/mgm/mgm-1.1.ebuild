# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/mgm/mgm-1.1.ebuild,v 1.6 2003/03/11 21:11:49 seemant Exp $

DESCRIPTION="ORNAMENTVM ROSACEVM INFERNVM PRATVLIS"
HOMEPAGE="http://www.xiph.org/mgm/index.html"
SRC_URI="http://www.xiph.org/mgm/${P}.tgz"
S=${WORKDIR}/${PN}

KEYWORDS="x86 sparc "
SLOT="0"
LICENSE="as-is"

RDEPEND=">=dev-lang/perl-5.6.1
	>=dev-perl/perl-tk-800.024"
src_unpack()
{
	unpack ${P}.tgz

	cd ${S}
	patch < ${FILESDIR}/${P}-gentoo.patch
}

src_install()
{
	cd ${S}

	dobin mgm
	dohtml doc/*
	insinto usr/share/mgm
	doins lib/*
	insinto usr/share/mgm/linux
	doins modules/linux/*
	insinto usr/share/mgm/share
	doins modules/share/*
}

