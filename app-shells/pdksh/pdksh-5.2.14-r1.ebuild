# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-shells/pdksh/pdksh-5.2.14-r1.ebuild,v 1.1 2000/08/07 12:47:39 achim Exp $

P=pdksh-5.2.14      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The Public Domain Korn Shell"
SRC_URI="ftp://ftp.cs.mun.ca/pub/pdksh/"${A}
HOMEPAGE="http://ww.cs.mun.ca/~michael/pdksh/"
CATEGORY="app-shells"

src_compile() {                           
	cd ${S}
	./configure --prefix=/usr --host=${CHOST}
	make 
}

src_install() {                               
	cd ${S}
	into /
	dobin ksh
	into /usr
	doman ksh.1
	dodoc BUG-REPORTS ChangeLog* CONTRIBUTORS LEGAL NEWS NOTES PROJECTS README
	docinto etc
	dodoc etc/*
}






