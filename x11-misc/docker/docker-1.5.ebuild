# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/docker/docker-1.5.ebuild,v 1.5 2003/09/05 23:18:18 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Openbox app which acts as a system tray for KDE and GNOME2"
SRC_URI="http://icculus.org/openbox/docker/${P}.tar.gz"
HOMEPAGE="http://icculus.org/openbox/docker/"

DEPEND=">=dev-libs/glib-2.0.4"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha"

src_compile() {

	emake || die

}

src_install () {

	dobin docker
	dodoc COPYING README
}
