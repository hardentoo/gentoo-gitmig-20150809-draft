# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/mserver/mserver-0.5.5-r1.ebuild,v 1.5 2003/10/11 18:56:20 lanius Exp $

DESCRIPTION="Daemon that provides control of dial-up links to other PCs on the LAN"
HOMEPAGE="http://cpwright.com/mserver/"
SRC_URI="http://cpwright.com/mserver/download/c-${P}.tar.gz"
S=${WORKDIR}/${P}
IUSE=""
DEPEND="sys-libs/pam"
RDEPEND="net-dialup/ppp"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack() {
	unpack c-${P}.tar.gz
	epatch ${FILESDIR}/${P}-errno.patch
}

src_compile() {
	econf \
		--sysconfdir=/etc \
		--localstatedir=/var || die
	emake || die
}

src_install() {
	dosbin mserver/mserver mchat/mchat authgen/authgen checkstat/checkstat
	doman mchat/mchat.8
	dodoc mserver/PROTOCOL README docs/index.html
	newdoc mchat/README README.mchat
	docinto images
	dodoc docs/images/*.gif docs/images/*.jpg
	#prepalldocs

	insinto /etc
	newins mserver/mserver.conf mserver.conf.dist

	insinto /etc/pam.d
	doins pam/mserver

	exeinto /etc/init.d
	newexe ${FILESDIR}/mserver-init mserver
}
