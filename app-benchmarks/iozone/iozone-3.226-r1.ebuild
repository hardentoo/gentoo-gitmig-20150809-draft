# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/iozone/iozone-3.226-r1.ebuild,v 1.3 2005/02/21 18:22:19 agriffis Exp $

# TODO
#        ->   linux-arm            (32bit)   <-
#        ->   linux-AMD64          (64bit)   <-
#        ->   linux-ia64           (64bit)   <-
#        ->   linux-powerpc        (32bit)   <-
#        ->   linux-powerpc64      (64bit)   <-
#        ->   linux-S390           (32bit)   <-
#        ->   linux-S390X          (64bit)   <-
#
#        ->   freebsd              (32bit)   <-
#        ->   macosx               (32bit)   <-
#        ->   netbsd               (32bit)   <-
#        ->   openbsd              (32bit)   <-
#        ->   openbsd-threads      (32bit)   <-
#
# ~ia64 ~s390 alpha(?) x86-fbsd

inherit eutils toolchain-funcs

DESCRIPTION="Filesystem benchmarking program"
HOMEPAGE="http://www.iozone.org/"
SRC_URI="http://www.iozone.org/src/current/${PN}${PV/./_}.tar"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~amd64 ~arm ppc ~ppc64 ~sparc x86 ~ia64"
IUSE=""

DEPEND="sys-devel/gcc
	>=sys-apps/sed-4
	virtual/libc"
RDEPEND="virtual/libc"

S=${WORKDIR}

src_unpack() {
	unpack ${PN}${PV/./_}.tar
	epatch ${FILESDIR}/${P}-ppc64.patch
}


src_compile() {
	cd src/current

	# Options FIX
	sed -i -e "s:CC	=.*:CC	=$(tc-getCC):g" \
		-e "s:-O3 -Dunix:${CFLAGS} -Dunix:g" makefile

	case ${ARCH} in
		x86|alpha)	PLATFORM="linux";;
		arm)		PLATFORM="linux-arm";;
		ppc)		PLATFORM="linux-powerpc";;
		ppc64)		PLATFORM="linux-powerpc64";;
		amd64)		PLATFORM="linux-AMD64";;
		ia64)		PLATFORM="linux-ia64";;
		s390)		PLATFORM="linux-S390";;
		x86-fbsd)	PLATFORM="freebsd";;
		*)			PLATFORM="linux-${ARCH}";;
	esac

	emake ${PLATFORM} || die "Compile failed"
}

src_install() {
	dosbin src/current/iozone || die
	dodoc docs/I*
	dodoc docs/Run_rules.doc
	dodoc src/current/Changes.txt
	doman docs/iozone.1

	insinto /usr/share/doc/${PF}
	cd src/current
	doins Generate_Graphs Gnuplot.txt gengnuplot.sh gnu3d.dem

	prepall
}

src_test() {
	cd ${T}
	${S}/src/current/iozone testfile || die "self test failed"
}
