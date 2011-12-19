# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/jmeter/jmeter-2.0.1-r2.ebuild,v 1.5 2011/12/19 13:06:31 sera Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Load test and measure performance on HTTP/FTP services and databases."
HOMEPAGE="http://jmeter.apache.org/"
SRC_URI="mirror://apache/jakarta/jmeter/source/jakarta-${P}_src.tgz"
COMMON_DEP="
	beanshell? ( dev-java/bsh )
	>=dev-java/bsf-2.3
	=dev-java/junit-3.8*
	dev-java/sun-javamail"
DEPEND=">=virtual/jdk-1.4
	doc? ( >=dev-java/velocity-1.4 )
	dev-java/ant-nodeps
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="beanshell doc"

S=${WORKDIR}/jakarta-${P}

src_unpack() {
	unpack ${A}
	cd "${S}/lib"
	# FIXME replace all bundled jars bug #63309
	# then rm -f *.jar
	use beanshell && java-pkg_jar-from bsh
	java-pkg_jar-from bsf-2.3
	java-pkg_jar-from junit
	java-pkg_jar-from sun-javamail
	java-pkg_filter-compiler jikes
}

src_compile() {
	local tasks="ant-nodeps"
	use doc && tasks="${tasks} velocity"
	ANT_TASKS="${tasks}" eant package $(use_doc docs-all) || die "compile problem"
}

src_install() {
	DIROPTIONS="--mode=0775"
	dodir /opt/${PN}
	local dest="${D}/opt/${PN}/"
	cp -pPR bin/ lib/ printable_docs/ "${dest}"
	if use doc; then
		cp -pPR printable_docs "${dest}" || die "Failed to install docs"
	fi
	dodoc README || die
	use doc && java-pkg_dohtml -r docs/*
}
