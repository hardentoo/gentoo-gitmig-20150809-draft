# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jcommon/jcommon-0.9.4.ebuild,v 1.2 2004/08/03 11:24:13 dholm Exp $

inherit java-pkg

DESCRIPTION="JCommon is a collection of useful classes used by JFreeChart, JFreeReport and other projects."
HOMEPAGE="http://www.jfree.org"
SRC_URI="mirror://sourceforge/jfreechart/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="doc jikes"
DEPEND=">=virtual/jdk-1.3
		dev-java/ant
		dev-java/junit
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jdk-1.3"

src_compile() {
	rm -f junit/*
	local antflags="compile javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant -f ant/build.xml ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_dojar ${P}.jar
	dodoc README.txt licence-LGPL.txt
	use doc && dohtml -r javadoc
}

