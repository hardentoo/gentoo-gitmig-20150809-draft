# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/bnr2/bnr2-0.12.3.ebuild,v 1.1 2003/11/30 03:18:37 vapier Exp $

DESCRIPTION="A great newsreader for alt.binaries.*"
HOMEPAGE="http://www.bnr2.org/"
SRC_URI="http://www.bnr2.org/BNR2beta-0.12.3.tgz
	http://www.bnr2.org/libborqt-6.9.0-qt2.3.so.tgz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc"
RDEPEND="virtual/x11"

S=${WORKDIR}/BNR2

src_install() {
	dodir /opt/bnr2
	cp -r * ${D}/opt/bnr2/
	dobin ${FILESDIR}/bnr2
}
