# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/wput/wput-0.4.ebuild,v 1.3 2004/05/07 18:55:00 kloeri Exp $

S="${WORKDIR}/${PN}"

DESCRIPTION="a tiny program that looks like wget and is designed to upload files or whole directories to remote ftp-servers"
HOMEPAGE="http://itooktheredpill.dyndns.org/wput/"
SRC_URI="http://itooktheredpill.dyndns.org/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=""

src_compile() {
	econf --prefix=/usr || die "configure failed"
	emake || die "make failed"
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man1
	einstall mandir=${D}/usr/share/man/man1 || die "install failed"

	# Documentation
	dodoc COPYING ChangeLog INSTALL TODO
}
