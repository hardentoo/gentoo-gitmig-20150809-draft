# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/phrack/phrack-61.ebuild,v 1.1 2003/08/16 06:15:49 vapier Exp $

MY_P=${PN}${PV}
DESCRIPTION="...a Hacker magazine by the community, for the community...."
HOMEPAGE="http://www.phrack.org/"
SRC_URI="http://www.phrack.org/archives/${MY_P}.tar.gz"

LICENSE="phrack"
SLOT="${PV}"
KEYWORDS="ppc x86"

S=${WORKDIR}/${MY_P}

src_install() {
	[ -d ${S} ] || cd ${WORKDIR}/*
	insinto /usr/share/doc/${PN}
	gzip *
	doins *
}
