# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xt-bin/xt-bin-20020426a.ebuild,v 1.3 2004/10/16 17:42:34 axxo Exp $

inherit java-pkg

DESCRIPTION="Java Implementation of XSL-Transformations"
SRC_URI="ftp://ftp.jclark.com/pub/xml/${PN/-bin}.zip
	ftp://ftp.jclark.com/pub/xml/xp.zip"
HOMEPAGE="http://www.blnz.com/xt/"
LICENSE="JamesClark"
SLOT="0"
KEYWORDS="x86 ~ppc"
DEPEND=">=virtual/jdk-1.2.2"
IUSE="doc"
RESTRICT="nomirror"

S=${WORKDIR}

src_compile() { :; }

src_install() {
	java-pkg_dojar *.jar
	dohtml xt.html
	use doc && java-pkg_dohtml -r demo/* && java-pkg_dohtml -r docs/*
}



