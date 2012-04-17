# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-sh/eselect-sh-0.3.ebuild,v 1.8 2012/04/17 16:15:03 ranger Exp $

EAPI=4

DESCRIPTION="Manages the /bin/sh (POSIX shell) symlink"
HOMEPAGE="https://github.com/mgorny/eselect-sh/"
SRC_URI="mirror://github/mgorny/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~s390 ~sh ~sparc x86 ~amd64-linux ~x86-linux ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

src_install() {
	insinto /usr/share/eselect/modules
	doins sh.eselect || die
}
