# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# Maintainer Thilo Bangert <bangert@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-dns/djbdns/djbdns-1.05-r2.ebuild,v 1.1 2002/06/29 00:55:03 bangert Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Excellent high-performance DNS services"
SRC_URI="http://cr.yp.to/djbdns/${P}.tar.gz"
HOMEPAGE="http://cr.yp.to/djbdns.html"

LICENSE="as-is"

DEPEND="virtual/glibc"
RDEPEND=">=sys-apps/daemontools-0.70
	sys-apps/ucspi-tcp"

src_compile() {                           
	echo "gcc ${CFLAGS}" > conf-cc
	echo "gcc" > conf-ld
	echo "/usr" > conf-home
	emake || die "emake failed"
}

src_install() {                               
	insinto /etc
	doins dnsroots.global
	into /usr
	for i in *-conf dnscache tinydns walldns rbldns pickdns axfrdns *-get *-data *-edit dnsip dnsipq dnsname dnstxt dnsmx dnsfilter random-ip dnsqr dnsq dnstrace dnstracesort
	do
		dobin $i
	done
	dodoc CHANGES FILES README SYSDEPS TARGETS TODO VERSION

	dobin ${FILESDIR}/dnscache-setup
	dobin ${FILESDIR}/tinydns-setup

}

pkg_postinst() {
	groupadd nofiles
	id dnscache || useradd -g nofiles -d /nonexistent -s /bin/false dnscache
	id dnslog || useradd -g nofiles -d /nonexistent -s /bin/false dnslog
	id tinydns || useradd -g nofiles -d /nonexistent -s /bin/false tinydns

	echo
	einfo "Use dnscache-setup and tinydns-setup to help you configure your nameservers!"
	echo
}

pkg_postrm() {
	userdel dnscache
	userdel dnslog
	userdel tinydns
}

