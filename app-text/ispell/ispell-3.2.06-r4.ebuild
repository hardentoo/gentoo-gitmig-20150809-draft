# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/ispell/ispell-3.2.06-r4.ebuild,v 1.2 2002/07/15 20:47:57 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Ispell is a fast screen-oriented spelling checker"
SRC_URI="http://fmg-www.cs.ucla.edu/geoff/tars/${P}.tar.gz
	mirror://gentoo/${P}-gentoo.diff.bz2"
HOMEPAGE="http://fmg-www.cs.ucla.edu/geoff/ispell.html"

DEPEND="sys-devel/bison
	>=sys-libs/ncurses-5.2"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86"

src_unpack() {
	
	unpack ${P}.tar.gz

	cd ${S}
	bzcat ${DISTDIR}/${P}-gentoo.diff.bz2 | patch || die

}

src_compile() {
	make config.sh || die

	#Fix config.sh to install to ${D}
	cp -p config.sh config.sh.orig
	sed \
		-e "s:^\(BINDIR='\)\(.*\):\1${D}\2:" \
		-e "s:^\(LIBDIR='\)\(.*\):\1${D}\2:" \
		-e "s:^\(MAN1DIR='\)\(.*\):\1${D}\2:" \
		-e "s:^\(MAN4DIR='\)\(.*\):\1${D}\2:" \
		< config.sh > config.sh.install
	
	make || die
}

src_install() {
	
	cp -p  config.sh.install config.sh

	#Need to create the directories to install into
	#before 'make install'. Build environment **doesn't**
	#check for existence and create if not already there.
	dodir /usr/bin /usr/lib/ispell /usr/share/info \
		/usr/share/man/man1 /usr/share/man/man5

	make \
		install || die "Installation Failed"
	
	rmdir ${D}/usr/share/man/man5
	rmdir ${D}/usr/share/info
	
	dodoc Contributors README WISHES

	dosed ${D}/usr/share/man/man1/ispell.1
}
