# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk+/gtk+-2.4.0.ebuild,v 1.1 2004/03/18 18:05:02 foser Exp $

inherit libtool flag-o-matic eutils

DESCRIPTION="Gimp ToolKit +"
HOMEPAGE="http://www.gtk.org/"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v2.4/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~amd64 ~hppa ~ia64 ~mips"
IUSE="doc tiff jpeg"

# virtual/x11
# Need this specific xfree version to get bugfree xinput support (#20407)

RDEPEND=">=x11-base/xfree-4.3.0-r3
	>=dev-libs/glib-2.4
	>=dev-libs/atk-1.0.1
	>=x11-libs/pango-1.4
	>=media-libs/libpng-1.2.1
	jpeg? ( >=media-libs/jpeg-6b-r2 )
	tiff? ( >=media-libs/tiff-3.5.7 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-1 )"

src_unpack() {

	unpack ${A}

	cd ${S}
	# Turn of --export-symbols-regex for now, since it removes
	# the wrong symbols
	epatch ${FILESDIR}/gtk+-2.0.6-exportsymbols.patch
	# beautifying patch for disabled icons
	epatch ${FILESDIR}/${PN}-2.2.1-disable_icons_smooth_alpha.patch

	autoconf || die

}

src_compile() {

	# bug 8762
	replace-flags "-O3" "-O2"

	elibtoolize

	econf \
		`use_enable doc gtk-doc` \
		`use_with jpeg libjpeg` \
		`use_with tiff libtiff` \
		--with-png \
		--with-gdktarget=x11 \
		--with-xinput \
		|| die

	# gtk+ isn't multithread friendly due to some obscure code generation bug
	MAKEOPTS="${MAKEOPTS} -j1" emake || die

}

src_install() {

	dodir /etc/gtk-2.0

	make DESTDIR=${D} install || die

	# Enable xft in environment as suggested by <utx@gentoo.org>
	dodir /etc/env.d
	echo "GDK_USE_XFT=1" >${D}/etc/env.d/50gtk2

	dodoc AUTHORS COPYING ChangeLog* HACKING INSTALL NEWS* README*

}

pkg_postinst() {

	gtk-query-immodules-2.0 >	/etc/gtk-2.0/gtk.immodules
	gdk-pixbuf-query-loaders >	/etc/gtk-2.0/gdk-pixbuf.loaders

	einfo "For gtk themes to work correctly after an update, you might have to rebuild your theme engines."
	einfo "Executing 'qpkg -f -nc /usr/lib/gtk-2.0/2.2.0/engines | xargs emerge' should do the trick if"
	einfo "you upgrade from gtk+-2.2 to 2.4 (requires gentoolkit)."

	env-update

}

pkg_postrm() {

	env-update

}
