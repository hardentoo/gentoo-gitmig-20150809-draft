# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/vmailmgr/vmailmgr-0.96.9-r1.ebuild,v 1.12 2003/02/13 14:43:42 vapier Exp $

S=${WORKDIR}/${P}

DESCRIPTION="vmailmgr - virtual domains for qmail"
SRC_URI="http://www.vmailmgr.org/current/${P}.tar.gz"
HOMEPAGE="http://www.vmailmgr.org"

DEPEND="virtual/glibc"
RDEPEND=">=sys-apps/ucspi-unix-0.34
	>=net-mail/qmail-1.03-r7
	>=net-mail/qmail-autoresponder-0.95"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

inherit gcc

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gentoo-r1.diff || die

}

src_compile() {

	export CXX=g++

	if [ "`gcc-major-version`" = "3" ]; then
		export LIBS="-lcrypt -lsupc++"
	fi

	if [ "`gcc-major-version`" = "2" ]; then
		export LIBS="-lcrypt"
	fi

	econf || die "./configure failed"

	emake || die "parallel make failed"

}

src_install () {

	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS INSTALL README TODO NEWS

	exeinto /var/lib/supervise/vmailmgrd
	newexe ${S}/scripts/vmailmgrd.run run

	exeinto /var/lib/supervise/vmailmgrd/log
	newexe ${S}/scripts/vmailmgrd-log.run run

	exeinto /etc/vmailmgr
	newexe ${S}/scripts/autoresponder.sh vdeliver-postdeliver

	doexe ${FILESDIR}/checkvpw-loginfail
	
	insinto /etc/vmailmgr
	doins ${FILESDIR}/socket-file
	doins ${FILESDIR}/separators

}

pkg_postinst() {

	einfo "To start vmailmgrd you need to link"
	einfo "/var/lib/supervise/vmailmgrd to /service"

}
