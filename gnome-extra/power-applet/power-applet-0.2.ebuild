# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Authour: Mikael Hallendal <hallski@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/power-applet/power-applet-0.2.ebuild,v 1.5 2002/10/04 05:39:50 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNOME Panel applet that shows the strength of a wavelan connection"
SRC_URI="http://www.eskil.org/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.eskil.org/power-applet/"
SLOT="0"
KEYWORDS="x86 sparc sparc64"
LICENSE="GPL-2"

RDEPEND=">=gnome-base/gnome-core-1.2.12
	 >=gnome-base/eel-1.0.2
	 >=gnome-base/libglade-0.17-r2"

DEPEND="${RDEPEND}
	sys-devel/gettext"

src_compile() {
  	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib
	assert "Package configuration failed."

  	emake || die "Package building failed."
}

src_install() {
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     install || die

  	dodoc AUTHORS COPYING* ChangeLog README NEWS
}
