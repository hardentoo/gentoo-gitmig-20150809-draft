# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/psi/psi-0.8.7.ebuild,v 1.2 2002/11/01 14:08:28 verwilst Exp $

IUSE="ssl"

S=${WORKDIR}/${P}
QV="1.0"
SRC_URI="mirror://sourceforge/psi/${P}.tar.bz2
	mirror://sourceforge/psi/qssl-${QV}.tar.bz2"
DESCRIPTION="QT 3.x Jabber Client, with Licq-like interface"
HOMEPAGE="http://psi.affinix.com"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND=">=x11-libs/qt-3
	ssl? ( >=dev-libs/openssl-0.9.6c )"

src_compile() {
	
	./configure --prefix=/usr || die
	make || die
	mv src/psi psi

        if [ "`use ssl`" ]; then
                cd ${WORKDIR}/qssl-${QV}
                qmake qssl.pro
                make
        fi	


}

src_install() {

	export PREFIX=${D}/usr
	export BINDIR=$PREFIX/bin
	export LIBDIR=$PREFIX/share/psi

	mkdir -p ${D}/usr/share/psi
	echo [Installing Psi]

	mkdir -p $BINDIR
	mkdir -p $LIBDIR

	echo Copying program to $BINDIR
	cp ./psi $BINDIR

	echo Copying additional files to $LIBDIR
	cp -r ./image $LIBDIR
	cp -r ./iconsets $LIBDIR
	cp -r ./sound $LIBDIR
	cp -r ./certs $LIBDIR

	dodoc README COPYING 



       if [ "`use ssl`" ]; then
	       cd ${WORKDIR}/qssl-${QV}
               cp libqssl.so ${D}/usr/share/psi
               cd ${S}
        fi

}
