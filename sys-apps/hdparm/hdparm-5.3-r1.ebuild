# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hdparm/hdparm-5.3-r1.ebuild,v 1.9 2003/09/07 01:31:20 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Utility to change hard drive performance parameters"
SRC_URI="http://www.ibiblio.org/pub/Linux/system/hardware/${P}.tar.gz"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/system/hardware/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 amd64 ppc ~sparc ~alpha hppa"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}"

src_compile() {
	emake || die "compile error"
}

src_install() {
	into /
	dosbin hdparm contrib/idectl

	exeinto /etc/init.d
	newexe ${FILESDIR}/hdparm-init hdparm

	doman hdparm.8
	dodoc hdparm.lsm Changelog README.acoustic hdparm-sysconfig
}

