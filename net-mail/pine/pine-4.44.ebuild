# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/pine/pine-4.44.ebuild,v 1.1 2002/01/18 10:52:51 hallski Exp $

S=${WORKDIR}/${PN}${PV}
DESCRIPTION="Pine 'a Program for Internet News & Email', email client"
SRC_URI="ftp://ftp.cac.washington.edu/${PN}/${PN}${PV}.tar.gz"
HOMEPAGE="http://www.washington.edu/pine/"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
	>=sys-libs/pam-0.72"

if [ "`use imap`" ] ; then
	PROVIDE="virtual/imap"
fi

src_unpack() {
	unpack ${A}
# 
#  patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
	cd ${S}/pine
	cp makefile.lnx makefile.orig
	sed -e "s:-g -DDEBUG:${CFLAGS}:" makefile.orig > makefile.lnx

	cd ${S}/pico
	cp makefile.lnx makefile.orig
	sed -e "s:-g -DDEBUG:${CFLAGS}:" makefile.orig > makefile.lnx
}

src_compile() {                           
	./build lnp || die
}

src_install() {                               
	into /usr
	dobin bin/pine bin/pico bin/pilot bin/mtest
	dosbin bin/imapd

	if [ "`use imap`" ] ; then
		insinto /usr/include
		doins imap/c-client/{mail,imap4r1,rfc822,linkage}.h
		dolib.a imap/c-client/c-client.a
	fi

	doman doc/pico.1 doc/pine.1

	insinto /etc
	doins doc/mime.types
	donewins doc/mailcap.unx mailcap

	dodoc CPYRIGHT README doc/brochure.txt doc/tech-notes.txt

	docinto imap
	dodoc imap/docs/*.txt imap/docs/CONFIG imap/docs/FAQ imap/docs/RELNOTES

	docinto imap/rfc
	dodoc imap/docs/rfc/*.txt

	docinto html/tech-notes
	dodoc doc/tech-notes/*.html
}




