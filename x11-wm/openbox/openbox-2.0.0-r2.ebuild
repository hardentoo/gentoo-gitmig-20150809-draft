# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/openbox/openbox-2.0.0-r2.ebuild,v 1.5 2002/12/09 04:42:03 manson Exp $

IUSE="nls"

inherit commonbox

S=${WORKDIR}/${P}
DESCRIPTION="Window manager based on BlackBox"
SRC_URI="ftp://sunsite.dk/projects/openbox/${P}.tar.gz"
HOMEPAGE="http://openbox.sunsite.dk"

SLOT="2"
LICENSE="BSD"
KEYWORDS="x86 sparc "

MYBIN="${PN}-dev"
mydoc="CHANGE* TODO LICENSE data/README*"
myconf="--enable-xinerama"
BOOTSTRAP="1"

src_install() {
	
	commonbox_src_install
}
