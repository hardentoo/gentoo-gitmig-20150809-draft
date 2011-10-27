# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/crda/crda-1.1.2.ebuild,v 1.6 2011/10/27 16:07:00 jer Exp $

EAPI="2"

inherit toolchain-funcs multilib eutils

DESCRIPTION="Central Regulatory Domain Agent for wireless networks."
HOMEPAGE="http://wireless.kernel.org/en/developers/Regulatory"
SRC_URI="http://linuxwireless.org/download/crda/${P}.tar.bz2"
LICENSE="as-is"
SLOT="0"

KEYWORDS="~amd64 ~mips ~ppc ~ppc64 ~x86"
IUSE=""
RDEPEND="dev-libs/libgcrypt
	dev-libs/libnl:1.1
	net-wireless/wireless-regdb"
DEPEND="${RDEPEND}
	dev-python/m2crypto"
RDEPEND="${RDEPEND}
	>=sys-fs/udev-152"

src_prepare() {
	epatch "${FILESDIR}/libnl:1.131-support.diff"
	sed -i \
		-e "s:\<pkg-config\>:$(tc-getPKG_CONFIG):" \
		Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" all_noverify || die "Compilation failed"
}

src_test() {
	emake CC="$(tc-getCC)" verify || die "emake verify failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
