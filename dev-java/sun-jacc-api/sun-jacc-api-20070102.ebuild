# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jacc-api/sun-jacc-api-20070102.ebuild,v 1.1 2007/01/10 23:57:40 caster Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Java Authorization Contract for Containers"
HOMEPAGE="http://java.sun.com/j2ee/javaacc/index.html"
# cvs -d :pserver:nichoj@cvs.dev.java.net:/cvs checkout glassfish/jacc-api
# cd glassfish
# mv jacc-api sun-jacc-api-${P}
# tar --exclude=CVS -cjvf sun-jacc-api-${P}.tar.bz2 sun-jacc-api-${P}
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="CDDL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	=dev-java/servletapi-2.4*"
RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	unpack ${A}
	cd ${S}
	# we need to patch the build file since we don't want to update an
	# existing jar-archive but build a new one (called jcc-api.jar)
	epatch ${FILESDIR}/20070102-jcc-api.patch
	java-pkg_jar-from servletapi-2.4 servlet-api.jar
}

src_compile() {
	eant -Djavaee.jar=servlet-api.jar
}

src_install() {
	java-pkg_dojar jcc-api.jar
}
