# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/avalon-framework/avalon-framework-4.2.0.ebuild,v 1.7 2005/05/26 09:58:10 luckyduck Exp $

inherit java-pkg

DESCRIPTION="Avalon Framework"
HOMEPAGE="http://avalon.apache.org/"
SRC_URI="mirror://apache/avalon/avalon-framework/source/${PF}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="4.2"
KEYWORDS="amd64 x86 ppc64 ~sparc ppc"
IUSE="doc jikes source"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.5
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4
	=dev-java/avalon-logkit-2*
	>=dev-java/log4j-1.2.9"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}

	cd ${S}
	cp ${FILESDIR}/build.xml ./build.xml || die "ANT update failure!"

	local libs="log4j,avalon-logkit-2.0"
	echo "classpath=`java-config -p ${libs}`" > build.properties
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "Compile failed!"
}

src_install() {
	java-pkg_dojar ${S}/dist/avalon-framework.jar

	dodoc NOTICE.TXT
	use doc && java-pkg_dohtml -r ${S}/target/docs/*
	use source && java-pkg_dosrc impl/src/java/*
}
