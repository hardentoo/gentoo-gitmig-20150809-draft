# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wgetpaste/wgetpaste-2.1.ebuild,v 1.3 2007/04/06 21:03:20 ranger Exp $

DESCRIPTION="Command-line interface to various pastebins"
HOMEPAGE="http://wgetpaste.zlin.dk/"
SRC_URI="${HOMEPAGE}/${PF}"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND="sys-apps/sed
		net-misc/wget"

src_install() {
	newbin "${DISTDIR}/${PF}" "${PN}"
}
