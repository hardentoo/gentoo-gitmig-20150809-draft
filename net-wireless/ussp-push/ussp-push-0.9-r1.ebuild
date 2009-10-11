# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ussp-push/ussp-push-0.9-r1.ebuild,v 1.2 2009/10/11 16:23:25 maekke Exp $

inherit toolchain-funcs

DESCRIPTION="OBEX object push client for Linux"
HOMEPAGE="http://www.xmailserver.org/ussp-push.html"
SRC_URI="http://www.xmailserver.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="net-wireless/bluez
		dev-libs/openobex"

src_unpack(){
	unpack ${A}
	cd "$S" || die "cd failed"

	# patch for bluez-libs -> bluez
	sed 's:hci_remote_name:hci_read_remote_name:g' -i obex_socket.c || \
		die "sed failed"

	sed -i \
		-e "s:/local::" \
		-e "s:gcc:$(tc-getCC):" \
		-e "s:^CFLAGS=.*:& ${CFLAGS}:" \
		Makefile || die "sed failed"
}

src_install() {
	dobin ${PN}

	dodoc doc/README
	dohtml doc/*.html
}

pkg_postinst() {
	einfo
	einfo "You can use ussp-push in three ways:"
	einfo "1. rfcomm bind /dev/rcomm0 00:11:22:33:44:55 10"
	einfo "   ussp-push /dev/rfcomm0 localfile remotefile"
	einfo "2. ussp-push 00:11:22:33:44:55@10 localfile remotefile"
	einfo "3. ussp-push 00:11:22:33:44:55 localfile remotefile"
	einfo
	einfo "See the README in /usr/share/doc/${PF}/ for more details."
	einfo
}
