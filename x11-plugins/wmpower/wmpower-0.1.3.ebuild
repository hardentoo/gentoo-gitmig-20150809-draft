# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmpower/wmpower-0.1.3.ebuild,v 1.7 2004/06/22 19:28:26 s4t4n Exp $

IUSE=""

DESCRIPTION="WMaker DockApp to get (and set) power management status for laptops. Supports both APM and ACPI kernels. Also has direct support for Toshiba hardware."
HOMEPAGE="http://wmpower.sourceforge.net/"
SRC_URI="mirror://sourceforge/wmpower/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND="virtual/x11"

src_compile() {
	emake || die
}

src_install() {
	dodir /usr/bin
	make DESTDIR=${D}/usr install || die
}
