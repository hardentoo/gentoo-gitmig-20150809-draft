# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/maven-bin/maven-bin-1.0.2.ebuild,v 1.7 2011/01/19 01:58:27 fordfrog Exp $

MY_PN=${PN/-bin}
MY_PV=${PV/_/-}
MY_P=${MY_PN}-${MY_PV}
DESCRIPTION="Project Management and Comprehension Tool for Java"
SRC_URI="mirror://apache/maven/binaries/${MY_P}.tar.gz"
HOMEPAGE="http://maven.apache.org/"
LICENSE="Apache-2.0"
SLOT="1.0"
KEYWORDS="~amd64 ~ppc ~x86"
DEPEND=">=virtual/jdk-1.5"
RDEPEND=">=virtual/jdk-1.5"
IUSE=""

S="${WORKDIR}/${MY_P}"
MAVEN=${PN}-${SLOT}
MAVEN_HOME="/usr/share/${MAVEN}"
MAVEN_BIN="${MAVEN_HOME}/bin"

src_compile() { :; }

src_install() {
	dodir ${MAVEN_HOME}
	insinto ${MAVEN_HOME}
	doins -r bin lib *.xsd plugins

	dodir ${MAVEN_BIN}
	exeinto ${MAVEN_BIN}
	doexe "${FILESDIR}/${MY_PN}"

	dodir /usr/bin
	dosym ${MAVEN_BIN}/${MY_PN} /usr/bin/${MY_PN} || die "dosym failed"
}

pkg_postinst() {
	elog "If you had maven-bin-1.1 installed and it was downgraded to this"
	elog "version, it is because maven-bin-1.1 has been reslotted to slot 1.1."
	elog "If you want to install maven-bin-1.1 back, just issue:"
	elog "  emerge =maven-bin-1.1*"
}
