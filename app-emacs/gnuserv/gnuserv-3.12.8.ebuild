# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/gnuserv/gnuserv-3.12.8.ebuild,v 1.3 2008/08/27 07:24:51 ulm Exp $

inherit elisp eutils

DESCRIPTION="Attach to an already running Emacs"
HOMEPAGE="http://meltin.net/hacks/emacs/"
SRC_URI="http://meltin.net/hacks/emacs/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND=""
RDEPEND="|| ( ~app-emacs/gnuserv-programs-${PV} virtual/xemacs )"

DOCS="ChangeLog README README.orig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/gnuserv-3.12.7-path-xemacs.patch"
}
