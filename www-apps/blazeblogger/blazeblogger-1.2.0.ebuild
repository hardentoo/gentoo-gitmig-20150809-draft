# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/blazeblogger/blazeblogger-1.2.0.ebuild,v 1.1 2012/05/29 21:16:35 xmw Exp $

EAPI=4

DESCRIPTION="a simple-to-use but capable CMS for the command line, producing static content"
HOMEPAGE="http://blaze.blackened.cz/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz
	doc? ( http://${PN}.googlecode.com/files/${PN}-doc-${PV}.tar.gz ) "

LICENSE="FDL-1.3 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -e '/-m 644 COPYING/d' \
		-e '/-m 644 INSTALL/d' \
		-i Makefile || die
}

src_install() {
	emake prefix="${D}/usr" config="${D}/etc" install

	use doc && dohtml -r ${WORKDIR}/${PN}-doc-${PV}/*
}
