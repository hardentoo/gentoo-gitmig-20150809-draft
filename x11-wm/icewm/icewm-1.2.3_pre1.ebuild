# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-wm/icewm/icewm-1.2.3_pre1.ebuild,v 1.1 2002/11/01 08:16:34 seemant Exp $

MY_P="icewm-1.2.3pre1"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Ice Window Manager"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://www.icewm.org"
IUSE="esd gnome imlib nls spell truetype"

DEPEND="virtual/x11
	esd? ( media-sound/esound )
	gnome? ( gnome-base/gnome )
	imlib? ( >=media-libs/imlib-1.9.10-r1 )
	nls? ( sys-devel/gettext )
	truetype? ( >=media-libs/freetype-2.0.9 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~sparc64"

src_unpack(){
	unpack ${A}

	cd ${S}
	
	patch -p1< ${FILESDIR}/${P}-gcc31-gentoo.patch || die
	patch -p1< ${FILESDIR}/${P}-aapm-gentoo.patch || die
	
	# icewm's doc dir layout is un-gentoo-like.  To fix it, we have
	# "make install" skip the docs install, and do it ourselves.  That also
	# means we have to adjust the Makefile so that it can find the help files
	# when you choose the 'help' item out of its menu.
	cp Makefile.in Makefile.in.orig
	sed 's:icewm-$(VERSION)::' \
		Makefile.in.orig > Makefile.in

	cp Makefile Makefile.orig
	sed 's:icewm-$(VERSION)::' \
		Makefile.orig > Makefile
	
	cd ${S}/src
	cp Makefile Makefile.orig
	sed 's:icewm-$(VERSION)::' \
		Makefile.orig > Makefile
}

src_compile(){

	use esd \
		&& myconf="${myconf} --with-esd-config=/usr/bin/esd-config"

	use nls \
		&& myconf="${myconf} --enable-nls --enable-i18n" \
		|| myconf="${myconf} --disable-nls --disable-i18n"

	use imlib \
		&& myconf="${myconf} --with-imlib --without-xpm" \
		|| myconf="${myconf} --without-imlib --with-xpm"

	use spell \
		&& myconf="${myconf} --enable-GtkSpell" \
		|| myconf="${myconf} --disable-GtkSpell"

	use truetype \
		&& myconf="${myconf} --enable-gradients" \
		|| myconf="${myconf} --disable-xfreetype"

	use x86 \
		&& myconf="${myconf} --enable-x86-asm" \
		|| myconf="${myconf} --disable-x86-asm"

	use gnome \
		&& myconf="${myconf} --with-gnome-menus" \
		|| myconf="${myconf} --without-gnome-menus"

	CXXFLAGS="${CXXFLAGS}" econf \
		--with-xpm \
		--with-libdir=/usr/lib/icewm \
		--with-cfgdir=/etc/icewm \
		--with-docdir=/usr/share/doc/${PF}/html \
		${myconf} || die "configure failed"

	emake || die "emake failed"
}

src_install(){
	make DESTDIR=${D} install || die

	dodoc AUTHORS BUGS CHANGES COPYING FAQ PLATFORMS README* TODO VERSION
	dohtml -a html,sgml doc/*
	
	echo "#!/bin/bash" > icewm
	echo "/usr/bin/icewm" >> icewm
	exeinto /etc/X11/Sessions
	doexe icewm
}
