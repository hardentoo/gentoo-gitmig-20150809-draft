# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/phex/phex-2.1.4.80.ebuild,v 1.3 2005/09/26 20:56:46 mkay Exp $

DESCRIPTION="java gnutella file-sharing application"
HOMEPAGE="http://phex.sourceforge.net/"
SRC_URI="mirror://sourceforge/phex/${P/-/_}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jdk-1.4
	virtual/x11"
S=${WORKDIR}/${P/-/_}

src_unpack() {
	unpack ${A}
	cd ${S}
	echo "PATH=/opt/${PN}/bin" >> ${S}/50${PN}
}

src_compile() {
	einfo "nothing to compile"
}

src_install() {
	insinto /opt/${PN}
	doins *.jar
	exeinto /opt/${PN}/bin
	newexe ${FILESDIR}/${PN}.sh ${PN}
	insinto /etc/env.d
	doins 50${PN}
	dohtml docs/readme/*
}
