# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/macutil/macutil-2.0_beta3.ebuild,v 1.16 2008/10/15 22:13:57 flameeyes Exp $

inherit eutils toolchain-funcs

MY_P=${P/_beta/b}
DESCRIPTION="A collection of programs to handle Macintosh files/archives on non-Macintosh systems"
HOMEPAGE="http://homepages.cwi.nl/~dik/english/ftp.html"
SRC_URI="ftp://ftp.cwi.nl/pub/dik/${MY_P/-/}.shar.Z"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~hppa ppc x86"
IUSE=""
RDEPEND=""
DEPEND="sys-apps/sed"
S=${WORKDIR}/${PN}

src_unpack() {
	gzip -dc "${DISTDIR}"/${A} | /bin/sh || die
	epatch "${FILESDIR}"/${PV}-gentoo.patch || die
	epatch "${FILESDIR}"/${P}-gcc4.patch

	cd ${PN}

	sed -i.orig \
		-e "s:-DBSD::g" \
		-e "s:-DDEBUG::g" \
		-e "s:/ufs/dik/tmpbin:${D}/usr/bin:g" \
		makefile || die "sed makefile failed"

	sed -i \
		-e '/^CFLAGS =/s:= -O:+=:' \
		-e '/(OBJ/s:CFLAGS:LDFLAGS:' \
		*/makefile || die "sed makefile [2] failed"
}

src_compile() {
	emake CC="$(tc-getCC)" || die "build failed"
}

src_install() {
	dodir /usr/bin
	einstall || die "install failed"

	doman man/*.1
	dodoc README doc/*
}
