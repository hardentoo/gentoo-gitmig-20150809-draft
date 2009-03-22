# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/memtest86+/memtest86+-2.10.ebuild,v 1.3 2009/03/22 08:40:40 spock Exp $

inherit mount-boot eutils

DESCRIPTION="Memory tester based on memtest86"
HOMEPAGE="http://www.memtest.org/"
SRC_URI="http://www.memtest.org/download/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="serial"
RESTRICT="test"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-2.10-hardcoded_cc.patch
	epatch "${FILESDIR}"/${PN}-1.70-gnu_hash.patch

	if use serial ; then
		sed -e 's/#define SERIAL_CONSOLE_DEFAULT 0/#define SERIAL_CONSOLE_DEFAULT 1/' -i config.h
	fi
}

src_compile() {
	emake || die
}

src_install() {
	insinto /boot/memtest86plus
	doins memtest.bin || die
	dodoc README README.build-process
}

pkg_postinst() {
	einfo
	einfo "memtest.bin has been installed in /boot/memtest86plus/"
	einfo "You may wish to update your bootloader configs"
	einfo "by adding these lines:"

	einfo " - For grub: (replace '?' with correct numbers for your boot partition)"
	einfo "    > title=Memtest86Plus"
	einfo "    > root (hd?,?)"
	einfo "    > kernel /boot/memtest86plus/memtest.bin"

	einfo " - For lilo:"
	einfo "    > image  = /boot/memtest86plus/memtest.bin"
	einfo "    > label  = Memtest86Plus"
	einfo
}
