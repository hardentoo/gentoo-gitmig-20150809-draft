# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmix/libmix-2.05.ebuild,v 1.2 2004/05/05 21:49:42 vapier Exp $

DESCRIPTION="Programs Crypto/Network/Multipurpose Library"
HOMEPAGE="http://mixter.void.ru/"
SRC_URI="http://mixter.void.ru/${P/.}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~arm ~hppa ~amd64"
IUSE="no-net2"

DEPEND="!no-net2? ( net-libs/libpcap net-libs/libnet )"

S=${WORKDIR}/${PN}-v${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:-O3 -funroll-loops:${CFLAGS}:" configure
}

src_compile() {
	econf `use_with no-net2` || die
	emake || die
}

src_install() {
	make \
		INSTALL_INCLUDES_IN=${D}/usr/include \
		INSTALL_LIBRARY_IN=${D}/usr/lib \
		INSTALL_MANPAGE_IN=${D}/usr/share/man \
		install || die
	dodoc CHANGES
}
