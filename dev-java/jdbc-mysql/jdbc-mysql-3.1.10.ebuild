# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdbc-mysql/jdbc-mysql-3.1.10.ebuild,v 1.1 2005/07/10 18:13:26 axxo Exp $

inherit eutils java-pkg

At=mysql-connector-java-${PV}

DESCRIPTION="MySQL JDBC driver"
HOMEPAGE="http://www.mysql.com"
SRC_URI="mirror://mysql/Downloads/Connector-J/${At}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="log4j c3p0"
RDEPEND=">=virtual/jre-1.2
	dev-java/jta
	log4j? ( dev-java/log4j )
	c3p0? ( dev-java/c3p0 )
	dev-java/jdbc2-stdext"
DEPEND=">=virtual/jdk-1.2
	${RDEPEND}
	dev-java/ant-core"

S=${WORKDIR}/${At}

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -f *.jar

	sed -i 's,{buildDir}/MANIFEST.MF,{buildDir}/META-INF/MANIFEST.MF,' build.xml || die "sed failed"

	mkdir src/lib-nodist
	cd src/lib
	rm -f *.jar
	java-pkg_jar-from jta
	java-pkg_jar-from jdbc2-stdext
	use log4j && java-pkg_jar-from log4j
	use c3p0 && java-pkg_jar-from c3p0
}

src_compile() {
	local antflags="dist"
	ant ${antflags} || die "build failed!"
}

src_install() {
	java-pkg_newjar build/${At}/${At}-bin.jar ${PN}.jar
	dodoc README CHANGES COPYING
}

