# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-cdt-bin/eclipse-cdt-bin-20020704.ebuild,v 1.6 2002/12/09 04:21:14 manson Exp $

S=${WORKDIR}/eclipse
DESCRIPTION="Eclipse Tools Platform"
HOMEPAGE="http://www.eclipse.org"
SRC_URI="http://download.eclipse.org/tools/cdt/downloads/cdt/20020704-CDT-initial.zip"

SLOT="2"
LICENSE="CPL-1.0"
KEYWORDS="x86 sparc "

DEPEND="=dev-util/eclipse-platform-bin-2.0*"

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack 20020704-CDT-initial.zip
}

src_install () {
	dodir /opt/eclipse/plugins

	cp -dpR org.eclipse.cdt* ${D}/opt/eclipse/plugins/

	dohtml org.eclipse.cdt.core/about.html
}
