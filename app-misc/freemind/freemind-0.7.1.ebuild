# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/freemind/freemind-0.7.1.ebuild,v 1.16 2005/07/02 18:29:21 axxo Exp $

inherit java-pkg

DESCRIPTION="Mind-mapping software written in Java"
HOMEPAGE="http://freemind.sf.net"
SRC_URI="mirror://sourceforge/freemind/${PN}-src-${PV//./_}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc amd64"
IUSE="doc jikes"
DEPEND="dev-java/ant
		>=virtual/jdk-1.4
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/${PN}

src_compile() {
	local antflags="jar browser"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} doc"
	ant ${antflags}
}

src_install() {
	cd ${WORKDIR}/bin/dist

	insinto /opt/${PN}/lib
	doins lib/*.jar browser/*.jar

	echo "#!/bin/sh" > ${PN}.sh
	echo "cd /opt/${PN}" >> ${PN}.sh
	echo "java -jar lib/${PN}.jar" >> ${PN}.sh

	cp -R ${S}/doc ${D}/opt/${PN}
	use doc && java-pkg_dohtml -r doc/

	into /opt
	newbin ${PN}.sh ${PN}
}

