# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/oidentd/oidentd-2.0.4-r1.ebuild,v 1.1 2002/10/23 15:22:01 phoenix Exp $

IUSE="ipv6"

DESCRIPTION="Another (RFC1413 compliant) ident daemon"
HOMEPAGE="http://dev.ojnk.net/"
SRC_URI="mirror://sourceforge/ojnk/${P}.tar.gz"
KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc"

src_compile() {	
	local myconf=""

	use ipv6 && \
		myconf="${myconf} --enable-ipv6" || \
		myconf="${myconf} --disable-ipv6"	


	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README TODO NEWS \
			${FILESDIR}/oidentd_masq.conf ${FILESDIR}/oidentd.conf
	exeinto /etc/init.d ; newexe ${FILESDIR}/oidentd-${PV}-init oidentd
	insinto /etc/conf.d ; newins ${FILESDIR}/oidentd-${PV}-confd oidentd
}

pkg_postinst() {
	einfo Example configuration files are in /usr/share/doc/${P}
}

