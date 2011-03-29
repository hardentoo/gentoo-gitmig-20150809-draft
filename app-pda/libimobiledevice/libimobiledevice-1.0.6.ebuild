# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libimobiledevice/libimobiledevice-1.0.6.ebuild,v 1.2 2011/03/29 01:44:24 ssuominen Exp $

EAPI=3

DESCRIPTION="Support library to communicate with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://www.libimobiledevice.org/"
SRC_URI="http://www.libimobiledevice.org/downloads/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="static-libs"

RDEPEND=">=app-pda/libplist-0.15
	>=app-pda/usbmuxd-0.1.4
	>=dev-libs/glib-2.14.1
	dev-libs/libgcrypt
	dev-libs/libtasn1
	>=net-libs/gnutls-1.6.3
	sys-fs/fuse
	virtual/libusb:1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	# Be careful when enabling Python, and read this thru:
	# http://bugs.gentoo.org/show_bug.cgi?id=361029
	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static) \
		--without-swig
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README

	find "${D}" -name '*.la' -exec rm -f {} +
}
