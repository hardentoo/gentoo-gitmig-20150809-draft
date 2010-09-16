# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcpu/wmcpu-1.4.ebuild,v 1.4 2010/09/16 08:58:47 s4t4n Exp $

EAPI="3"

inherit flag-o-matic

DESCRIPTION="wmcpu is a dockapp to monitor memory and CPU usage, similar to xosview"
HOMEPAGE="http://dockapps.org/file.php/id/306"
SRC_URI="http://denilsonsa.sh.nu/~denilson/${P}.tar.gz
	http://denilsonsa.selfip.org/~denilson/${P}.tar.gz
	http://dockapps.org/download.php/id/673/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
RDEPEND="${RDEPEND}
	x11-proto/xextproto"

src_prepare() {
	#Honour Gentoo LDFLAGS, see bug #337523
	sed -e 's/LDFLAGS/LIBS/g' -i Makefile
	sed -e 's/\$(CFLAGS)/\$(LDFLAGS)/' -i Makefile
}

src_compile() {
	# We then add the default -Wall from Makefile to CFLAGS
	emake CFLAGS="${CFLAGS} -Wall" || die "emake failed"
}

src_install () {
	dobin wmcpu
	dodoc ChangeLog README
}
