# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-fs/samba-winbind/samba-winbind-20010329-r6.ebuild,v 1.1 2001/10/19 17:17:46 woodchip Exp $

A=samba-tng-cvs-${PV}.tbz2
S=${WORKDIR}/tng
DESCRIPTION="Enhanced NT User management for unix"
SRC_URI="ftp://ftp.ibiblio.org/pub/Linux/distributions/gentoo/gentoo-sources/${A}"
HOMEPAGE="http://www.samba-tng.org"

DEPEND="virtual/glibc
	pam? ( >=sys-libs/pam-0.72 )"

src_unpack() {
  unpack ${A}
  cd ${S}/source
  patch -p0 < ${FILESDIR}/${P}-Makefile.in-gentoo.diff
}

src_compile() {

  local myconf
  if [ "`use pam`" ]
  then
    myconf="--without-pam"
    echo "disabled cuz broken"
#    myconf="--with-pam"
  else
    myconf="--without-pam"
  fi

    cd ${S}/source
    # We want static versions of winbind and pam_winbind
    try ./configure --prefix=/usr --host=${CHOST} --enable-static=yes --enable-shared=no \
	--sysconfdir=/etc/smb --localstatedir=/var/log --libdir=/etc/smb --sbindir=/usr/sbin \
	--without-automount \
	--with-privatedir=/etc/smb/private --with-lockdir=/var/lock $myconf
    try make
    try make nsswitch nsswitch/pam_winbind.so

}

src_install () {
	cd ${S}/source
	dodir /usr
	dodir /etc/smb
	dodir /usr/share/swat
	dodir /usr/share/doc/${P}/html/book
	dodir /var/log
	dodir /var/lock
	try make install prefix=${D}/usr BASEDIR=${D}/usr LIBDIR=${D}/etc/smb VARDIR=${D}/var/log \
		PRIVATEDIR=${D}/etc/smb/private SWATDIR=${D}/usr/share/swat \
		LOCKDIR=${D}/var/lock SBINDIR=${D}/usr/sbin MANDIR=${D}/usr/share/man
  cd ${S}/source
  dosbin bin/winbindd
  dobin bin/wbinfo
  exeinto /lib
  newexe nsswitch/libnss_winbind.so libnss_winbind.so.2
  exeinto /lib/security
  doexe nsswitch/pam_winbind.so

  cd ${S}
  dodoc COPYING README WHATSNEW.txt

  cd docs/manpages
  doman samedit.8 wbinfo.1 winbindd.8

  cd ../htmldocs
  docinto html
  dodoc *.html

  exeinto /etc/init.d ; newexe ${FILESDIR}/samba-winbind.rc6 samba-winbind
}
