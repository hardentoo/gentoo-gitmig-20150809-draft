# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/profiler/profiler-1.ebuild,v 1.2 2003/10/27 10:37:06 aliz Exp $

DESCRIPTION="provides 3D visual representation of file system statistics"
HOMEPAGE="http://visualversion.com/profiler/"
SRC_URI="http://visualversion.com/profiler/profiler.jar"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"

RDEPEND="virtual/jre"

S=${WORKDIR}

src_unpack() {
	cp ${DISTDIR}/${A} ${S}/
}

src_install() {
	dobin ${FILESDIR}/profiler
	dojar ${A}
}
