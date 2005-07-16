# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/renaissance/renaissance-0.8.0.ebuild,v 1.4 2005/07/16 15:40:23 swegener Exp $

inherit gnustep

S=${WORKDIR}/${P/r/R}

DESCRIPTION="GNUstep Renaissance allows you to describe your user interfaces in simple and intuitive XML files."
HOMEPAGE="http://www.gnustep.it/Renaissance/index.html"
SRC_URI="http://www.gnustep.it/Renaissance/Download/${P/r/R}.tar.gz"

KEYWORDS="~x86 ~ppc"
LICENSE="LGPL-2.1"
SLOT="0"

IUSE="doc"
DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"

egnustep_install_domain "System"

src_install() {
	cd ${S}
	egnustep_env
	egnustep_install || die
	if use doc ; then
		egnustep_env
		cd Documentation
		egnustep_make
		egnustep_install
		mkdir -p ${TMP}/tmpdocs
		mv ${D}$(egnustep_install_domain)/Library/Documentation/* ${TMP}/tmpdocs
		mkdir -p ${D}$(egnustep_install_domain)/Library/Documentation/Developer/Renaissance
		mv ${TMP}/tmpdocs/* ${D}$(egnustep_install_domain)/Library/Documentation/Developer/Renaissance
		cd ..
	fi
	egnustep_package_config
}
