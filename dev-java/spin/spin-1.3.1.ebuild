# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/spin/spin-1.3.1.ebuild,v 1.9 2005/07/11 22:02:41 axxo Exp $

inherit java-pkg

DESCRIPTION="Transparent threading solution for non-freezing Swing applications."
HOMEPAGE="http://spin.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 amd64 sparc ppc"
IUSE="doc jikes source"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.4"
S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:${java.home}/src::' -i build.xml || die "sed failed"
}

src_compile() {
	local antflags="dist"
	use doc && antflags="${antflags} doc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "failed to build"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	use doc && java-pkg_dohtml -r ${S}/docs/api/*
	use source && java-pkg_dosrc src/*
}
