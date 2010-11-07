# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-led-notification/pidgin-led-notification-0.1.ebuild,v 1.1 2010/11/07 17:22:06 xmw Exp $

EAPI=3

inherit eutils multilib toolchain-funcs

DESCRIPTION="Pidgin plugin to notify by writining '1's and '0's to (led) control files"
HOMEPAGE="http://sites.google.com/site/simohmattila/led-notification"
MY_PN=${PN/pidgin-/}
MY_P=${MY_PN}-${PV}
SRC_URI="http://sites.google.com/site/simohmattila/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-im/pidgin
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-hardware.patch
}

src_compile() {
	$(tc-getCC) \
		${CFLAGS} -fpic $(pkg-config --cflags gtk+-2.0 pidgin) \
		-shared ${MY_PN}.c -o ${MY_PN}.so \
		${LDFLAGS} $(pkg-config --libs gtk+-2.0 pidgin) || die
}

src_install() {
	insinto ${EPREFIX}/usr/$(get_libdir)/pidgin
	insopts -m755
	doins ${MY_PN}.so || die
	dodoc README || die
}
