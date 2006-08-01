# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-config-wrapper/java-config-wrapper-0.10-r3.ebuild,v 1.1 2006/08/01 22:56:07 nichoj Exp $

inherit eutils
DESCRIPTION="Wrapper for java-config"
HOMEPAGE="http://www.gentoo.org/proj/en/java"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
DEPEND="!<dev-java/java-config-1.3"
RDEPEND="app-portage/portage-utils"

IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	# Remove unnecessary file
	rm src/shell/java-check-environment.orig
	# Fix regression bug #140752
	epatch ${FILESDIR}/${PN}-0.9-qfile.patch
	cd src/shell
	epatch ${FILESDIR}/${P}-fixer.patch
	epatch ${FILESDIR}/${P}-check.patch
}

src_install() {
	dobin src/shell/*
}
