# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/ochusha/ochusha-0.5.ebuild,v 1.3 2004/04/07 03:47:15 usata Exp $

IUSE=""

DESCRIPTION="Ochusha - 2ch viewer for GTK+"
HOMEPAGE="http://ochusha.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/8439/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/xft
	>=x11-libs/gtk+-2.2.4
	>=dev-libs/glib-2.2.3
	>=dev-libs/libxml2-2.5.0
	>=gnome-base/libghttp-1.0.9
	sys-libs/zlib
	sys-devel/gettext"

S=${WORKDIR}/${P}

src_compile() {

	if has_version '>=x11-libs/gtk+-2.4' ; then
		perl -i -pe "s/-D.*?DISABLE_DEPRECATED//g" gtk2/Makefile* || die
	fi

	econf --enable-regex --with-included-oniguruma || die
	emake || die
}

src_install() {

	einstall || die

	dodoc ABOUT-NLS ACKNOWLEDGEMENT AUTHORS BUGS \
		ChangeLog INSTALL* NEWS README TODO
}
