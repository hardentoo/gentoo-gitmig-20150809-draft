# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/wolk-sources/wolk-sources-4.11.ebuild,v 1.1 2004/02/26 08:22:11 nerdboy Exp $

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"

inherit kernel || die

OKV=2.4.20
KV=${OKV}-wolk4.10s
S=${WORKDIR}/linux-${KV}
DESCRIPTION="Working Overloaded Linux Kernel (Server-Edition)"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~arm ~mips"
SRC_PATH="mirror://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2"

SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	mirror://sourceforge/wolk/linux-${OKV}-wolk4.10s.patch.bz2
	mirror://sourceforge/wolk/linux-${OKV}-wolk4.10s-to-4.11s.patch.bz2"

SLOT="${KV}"
HOMEPAGE="http://wolk.sourceforge.net http://www.kernel.org"

src_unpack() {

	unpack linux-${OKV}.tar.bz2 || die
	mv linux-${OKV} linux-${KV} || die
	cd ${WORKDIR}/linux-${KV} || die
	epatch ${DISTDIR}/linux-${KV}.patch.bz2 || die
	epatch ${DISTDIR}/linux-${OKV}-wolk4.10s-to-4.11s.patch.bz2 || die

	kernel_universal_unpack
}

pkg_postinst() {
	einfo
	einfo "This is the base WOLK 4.10 Server Edition with no workstation patches."
	einfo
}
