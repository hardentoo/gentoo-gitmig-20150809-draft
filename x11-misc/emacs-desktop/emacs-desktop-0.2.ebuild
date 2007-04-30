# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/emacs-desktop/emacs-desktop-0.2.ebuild,v 1.9 2007/04/30 21:43:52 chainsaw Exp $

inherit eutils fdo-mime

DESCRIPTION="Desktop entry and icon for Emacs"
HOMEPAGE="http://www.gentoo.org/proj/en/lisp/emacs/index.xml"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc64 ~sparc ~x86 ~ppc"
IUSE=""

src_install() {
	domenu emacs.desktop emacsclient.desktop
	doicon emacs.png
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
