# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/bcel/bcel-5.1.ebuild,v 1.5 2004/01/17 04:29:48 strider Exp $

inherit java-pkg eutils

DESCRIPTION="The Byte Code Engineering Library: analyze, create, manipulate Java class files"
HOMEPAGE="http://jakarta.apache.org/bcel/"
SRC_URI="http://jakarta.apache.org/builds/jakarta-bcel/release/v${PV}/${PN}-${PV}-src.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE="doc jikes"
DEPEND=""
RDEPEND=">=virtual/jdk-1.2
	>=dev-java/regexp-1.2
	jikes? ( dev-java/jikes )"
DEP_APPEND="regexp"

src_compile() {
	ANT_OPTS="${myc}"
	CLASSPATH="${CLASSPATH}:`/usr/bin/java-config --classpath=regexp`"
	epatch ${FILESDIR}/${P}-gentoo.diff

	use jikes && export ANT_OPTS="${ANT_OPTS} -Dbuild.compiler=jikes"
	ant jar || die "Compile failed during jar target."
	if [ -n "`use doc`" ] ; then
		echo "Building Javadocs"
		ant apidocs > /dev/null
	fi
}

src_install() {
	use doc && dohtml -r docs/
	dodoc LICENSE.txt
	java-pkg_dojar bin/bcel.jar
}
