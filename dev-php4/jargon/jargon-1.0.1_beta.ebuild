# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/jargon/jargon-1.0.1_beta.ebuild,v 1.1 2005/09/18 14:04:25 hollow Exp $

inherit php-lib-r1

DESCRIPTION="Convenience tools built on top of Creole."
HOMEPAGE="http://creole.phpdb.org/wiki/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

MY_P="creole-php4-${PV/_/}"
SRC_URI="http://creole.tigris.org/files/documents/996/21587/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

RDEPEND="${RDEPEND} >=dev-php4/creole-1.0.1_beta"

need_php_by_category

src_install() {
	# install files
	php-lib-r1_src_install ./classes/jargon `find ./classes/jargon -type f -print | sed -e "s|./classes/jargon||g"`
}
