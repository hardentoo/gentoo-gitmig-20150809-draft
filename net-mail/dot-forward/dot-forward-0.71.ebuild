# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/dot-forward/dot-forward-0.71.ebuild,v 1.8 2003/02/13 14:28:15 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Dot-forward reads sendmail's .forward files under qmail."
HOMEPAGE="http://cr.yp.to/dot-forward.html"
SRC_URI="http://cr.yp.to/software/dot-forward-0.71.tar.gz"

DEPEND="virtual/glibc
	sys-apps/groff"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc "

src_unpack() {

	cd ${WORKDIR}
	unpack ${P}.tar.gz

	cd ${S}

	echo "gcc ${CFLAGS}" > conf-cc
	echo "gcc" > conf-ld

}

src_compile() {

	cd ${S}

	emake it || die
}



src_install() {				 

	into /usr
	dodoc BLURB CHANGES FILES INSTALL README SYSDEPS TARGETS THANKS
	dodoc TODO VERSION
 
	insopts -o root -g qmail -m 755
	insinto /var/qmail/bin
	doins dot-forward

	into /usr
	for i in *.1
	do
		doman $i
	done

}
