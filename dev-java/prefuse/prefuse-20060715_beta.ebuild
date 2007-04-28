# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/prefuse/prefuse-20060715_beta.ebuild,v 1.4 2007/04/28 22:19:06 betelgeuse Exp $

inherit java-pkg-2 java-ant-2

MY_PV=${PV/_beta/}
MY_P=${PN}-beta-${MY_PV}
DESCRIPTION="User interface toolkit for building highly interactive visualizations of structured and unstructured data."
SRC_URI="mirror://sourceforge/prefuse/${MY_P}.zip"
HOMEPAGE="http://prefuse.org"
LICENSE="BSD"
SLOT="2006"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="doc examples source"

COMMON_DEP="=dev-java/lucene-1*"

DEPEND=">=virtual/jdk-1.4
	${COMMON_DEP}
	>=dev-java/ant-core-1.4
	>=app-arch/unzip-5.50-r1
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

S=${WORKDIR}/${PN}-beta

src_unpack() {
	unpack ${A}
	cd ${S}

	find lib/ -name "*.jar" | xargs rm -v
}

src_compile() {
	java-pkg_filter-compiler jikes
	local targets="prefuse"
	use examples && targets="${targets} demos"
	eant $(use_doc api) ${targets} \
		-Dlucene.lib=$(java-pkg_getjars lucene-1)
}

src_install() {
	java-pkg_dojar build/*.jar

	dodoc readme.txt
	use doc && java-pkg_dohtml -r doc/api
	use source && java-pkg_dosrc src/*
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r demos/*
	fi
}
