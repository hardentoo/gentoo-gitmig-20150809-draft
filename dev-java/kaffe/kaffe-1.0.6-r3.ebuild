# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/kaffe/kaffe-1.0.6-r3.ebuild,v 1.2 2002/07/11 06:30:19 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A cleanroom, open source Java VM and class libraries"
SRC_URI="http://www.kaffe.org/ftp/pub/kaffe/${P}.tar.gz"
HOMEPAGE="http://www.kaffe.org/"

DEPEND=">=dev-libs/gmp-3.1
        >=media-libs/jpeg-6b
        >=media-libs/libpng-1.2.1
	virtual/glibc
	virtual/x11"
LICENSE="GPL-2"

src_unpack() {
	unpack ${A}
	patch -p0 <${FILESDIR}/${PF}-gentoo.diff || die
}

src_compile() {
	./configure --host=${CHOST}					\
		    --prefix=/opt/kaffe 
	make || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodir /etc/env.d
	insinto /etc/env.d
	doins ${FILESDIR}/30kaffe
	#30kaffe will set up the ld.so.path, path, manpath, etc.
}
