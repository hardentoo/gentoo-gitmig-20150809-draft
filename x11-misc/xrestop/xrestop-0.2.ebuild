# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xrestop/xrestop-0.2.ebuild,v 1.3 2004/03/16 17:10:39 augustus Exp $

IUSE=""

DESCRIPTION="'Top' like statistics of X11 client's server side resource usage"
SRC_URI="http://www.freedesktop.org/Software/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.freedesktop.org/Software/xrestop/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

RDEPEND="virtual/x11"

src_install () {
	einstall || die
	dodoc AUTHORS ChangeLog INSTALL  NEWS README COPYING
}
