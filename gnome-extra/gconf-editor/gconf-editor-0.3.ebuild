# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gconf-editor/gconf-editor-0.3.ebuild,v 1.4 2002/10/04 05:36:54 vapier Exp $ 

S=${WORKDIR}/${P}
DESCRIPTION="an editor to the GConf2 system"
SRC_URI="mirror://gnome/2.0.0/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc x86 alpha"

RDEPEND=">=gnome-base/gconf-1.2.0
	>=x11-libs/gtk+-2.0.6-r1
	>=dev-libs/glib-2.0.6-r1"

DEPEND="${RDEPEND} >=dev-util/pkgconfig-0.12.0"

src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--localstatedir=/var/lib \
		--enable-platform-gnome-2 \
		--enable-debug=yes || die "configure failed"

	emake || die "emake failed"
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		localstatedir=${D}/var/lib \
		install || die "install failed"
    
	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING README* INSTALL NEWS
}
