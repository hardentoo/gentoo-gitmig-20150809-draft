# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/tightvnc/tightvnc-1.2.2.ebuild,v 1.1 2002/02/10 21:07:04 verwilst Exp $

S="${WORKDIR}/vnc_unixsrc"
DESCRIPTION="A great client/server software package allowing remote network access to graphical desktops."
SRC_URI="http://prdownloads.sourceforge.net/vnc-tight/${P}_unixsrc.tar.bz2"
HOMEPAGE="http://www.tightvnc.com"
SLOT="0"
DEPEND="virtual/glibc
		>=x11-base/xfree-4.1.0
		>=sys-devel/perl-5.6.1"

RDEPEND=$DEPEND

src_compile() {

	cd ${S}
	xmkmf || die
	make World || die
	cd Xvnc
	make World || die

}

src_install() {

	cd ${S}
	mkdir -p ${D}/usr/bin
	./vncinstall ${D}/usr/bin || die

}
