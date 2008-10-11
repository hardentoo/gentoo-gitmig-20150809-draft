# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/jabref/jabref-2.4.1.ebuild,v 1.1 2008/10/11 22:06:17 caster Exp $

EAPI=2

JAVA_PKG_IUSE="doc"
inherit eutils java-pkg-2 java-ant-2

MY_PV="${PV/_beta/b}"

DESCRIPTION="GUI frontend for BibTeX, written in Java"
HOMEPAGE="http://jabref.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/JabRef-${MY_PV}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

CDEPEND="dev-java/spin:0
	>=dev-java/glazedlists-1.7.0:0[java5]
	>=dev-java/antlr-2.7.3:0[java]
	>=dev-java/jgoodies-forms-1.1.0:0
	dev-java/jgoodies-looks:2.0
	>=dev-java/microba-0.4.3:0
	dev-java/jempbox:0
	dev-java/pdfbox:0
	dev-java/commons-logging:0
	dev-java/jpf:1.5"

RDEPEND=">=virtual/jre-1.5
	${CDEPEND}"

DEPEND=">=virtual/jdk-1.5
	${CDEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	# moves jarbundler definition to where it's needed (not by us)
	# don't call unjarlib, don't want to absorb deps
	# failonerror in jpfcodegen
	epatch "${FILESDIR}/${PN}-2.4-build.xml.patch"

	mkdir libs || die
	mv lib/antlr-3.0b5.jar libs/ || die
	mv lib/plugin/JPFCodeGen* libs/ || die

	rm -v lib/*.jar lib/plugin/*.jar \
		src/java/net/sf/jabref/plugin/core/generated/*.java || die

	mv libs/JPFCodeGen* lib/plugin/ || die
	java-utils-2_src_prepare
}

JAVA_ANT_REWRITE_CLASSPATH="true"

src_compile() {
	java-pkg_filter-compiler jikes

	local gcp=$(java-pkg_getjars antlr,spin,glazedlists,jgoodies-looks-2.0,jgoodies-forms,microba,jempbox,pdfbox,commons-logging,jpf-1.5)
	gcp="${gcp}:libs/antlr-3.0b5.jar"
	eant -Dgentoo.classpath="${gcp}" jars \
		$(use_doc -Dbuild.javadocs=build/docs/api javadocs)
}

src_install() {
	java-pkg_newjar build/lib/JabRef-${MY_PV}.jar
	java-pkg_dojar libs/antlr-3.0b5.jar
	java-pkg_dojar lib/plugin/JPFCodeGenerator-rt.jar

	use doc && java-pkg_dojavadoc build/docs/api
	dodoc src/txt/README

	java-pkg_dolauncher ${PN} \
		--main net.sf.jabref.JabRef

	newicon src/images/JabRef-icon-48.png JabRef-icon.png || die
	make_desktop_entry jabref JabRef JabRef-icon Office
}
