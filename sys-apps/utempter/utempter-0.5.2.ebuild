# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/utempter/utempter-0.5.2.ebuild,v 1.1 2002/12/03 13:30:54 danarmak Exp $

DESCRIPTION="Daemon that allows non-privileged apps to have root access without compromising security"
HOMEPAGE="www.redhat.com" # no homepage really, but redhat are the authors
SRC_URI="mirror://gentoo/$P.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="virtual/glibc"

S="${WORKDIR}/${P}"

src_compile() {
	export RPM_OPT_FLAGS="$CFLAGS"
	make || die
}

src_install() {
	make RPM_BUILD_ROOT="$D" install
	dobin utmp
	dodoc COPYING
}
