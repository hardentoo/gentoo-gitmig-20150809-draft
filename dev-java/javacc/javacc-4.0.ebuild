# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javacc/javacc-4.0.ebuild,v 1.1 2006/01/22 05:08:34 nichoj Exp $

inherit java-pkg eutils

DESCRIPTION="Java Compiler Compiler"
HOMEPAGE="https://javacc.dev.java.net/servlets/ProjectHome"
SRC_URI="https://${PN}.dev.java.net/files/documents/17/26783/${P}src.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc examples jikes source"
DEPEND=">=virtual/jdk-1.3
	sys-apps/sed
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.3"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-javadoc.patch
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "compilation failed"

	cp ${FILESDIR}/${P} ${WORKDIR}/${PN}/ || die "Missing env file ${P}"
	sed -i \
		-e "s:@PV@:${PV}:" \
		-e "s:@PN@:${PN}:" \
		${P} || die "Failed to sed"
}

src_install() {
	java-pkg_dojar bin/lib/${PN}.jar

	if use doc; then
		dodoc README
		java-pkg_dohtml -r www/*
		java-pkg_dohtml -r doc/api
	fi
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -R examples/* ${D}/usr/share/doc/${PF}/examples
	fi
	use source && java-pkg_dosrc src/*

	newbin ${FILESDIR}/javacc.sh-${PV} javacc
	newbin ${FILESDIR}/jjdoc-${PV} jjdoc
	newbin ${FILESDIR}/jjtree-${PV} jjtree

	dodir /etc/env.d/java
	insinto /etc/env.d/java
	newins ${P} 22javacc || die "Missing ${PF}"
}

pkg_postinst() {
	#close bug 61975
	if [ -f /etc/env.d/22javacc ] ; then
		rm -f /etc/env.d/22javacc
	fi
}
