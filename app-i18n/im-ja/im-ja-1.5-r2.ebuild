# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/im-ja/im-ja-1.5-r2.ebuild,v 1.1 2011/01/12 15:06:47 matsuu Exp $

EAPI="3"
inherit autotools gnome2 eutils multilib

DESCRIPTION="A Japanese input module for GTK2 and XIM"
HOMEPAGE="http://im-ja.sourceforge.net/"
SRC_URI="http://im-ja.sourceforge.net/${P}.tar.gz
	http://im-ja.sourceforge.net/old/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="gnome canna freewnn skk anthy"
# --enable-debug causes build failure with gtk+-2.4
#IUSE="${IUSE} debug"

RDEPEND=">=dev-libs/glib-2.4:2
	>=dev-libs/atk-1.6
	>=x11-libs/gtk+-2.4:2
	>=x11-libs/pango-1.2.1
	>=gnome-base/gconf-2.4:2
	>=gnome-base/libglade-2.4
	>=gnome-base/libgnomeui-2.4
	gnome? (
		|| (
			gnome-base/gnome-panel[bonobo]
			<gnome-base/gnome-panel-2.32
		)
	)
	freewnn? ( app-i18n/freewnn )
	canna? ( app-i18n/canna )
	skk? ( virtual/skkserv )
	anthy? ( app-i18n/anthy )"
DEPEND="${RDEPEND}
	dev-lang/perl
	dev-perl/URI
	dev-util/pkgconfig"

DOCS="AUTHORS README ChangeLog TODO"

update_gtk_immodules() {
	local GTK2_CONFDIR="/etc/gtk-2.0"
	has_multilib_profile && GTK2_CONFDIR="${GTK2_CONFDIR}/${CHOST}"
	mkdir -p "${EPREFIX}${GTK2_CONFDIR}"

	if [ -x "${EPREFIX}/usr/bin/gtk-query-immodules-2.0" ] ; then
		"${EPREFIX}/usr/bin/gtk-query-immodules-2.0" > "${EPREFIX}${GTK2_CONFDIR}/gtk.immodules"
	fi
}

src_prepare() {
	epatch "${FILESDIR}/${P}-gentoo.patch"
	eautoreconf
}

src_configure() {
	local myconf
	# You cannot use `use_enable ...` here. im-ja's configure script
	# doesn't distinguish --enable-canna from --disable-canna, so
	# --enable-canna stands for --disable-canna in the script ;-(
	use gnome || myconf="$myconf --disable-gnome"
	use canna || myconf="$myconf --disable-canna"
	use freewnn || myconf="$myconf --disable-wnn"
	use anthy || myconf="$myconf --disable-anthy"
	use skk || myconf="$myconf --disable-skk"
	#use debug && myconf="$myconf --enable-debug"

	# gnome2_src_compile automatically sets debug IUSE flag
	econf $myconf || die "econf im-ja failed"
}

src_install() {
	gnome2_src_install

	sed -e "s:@EPREFIX@:${EPREFIX}:" "${FILESDIR}/xinput-${PN}" > "${T}/${PN}.conf" || die
	insinto /etc/X11/xinit/xinput.d
	doins "${T}/${PN}.conf" || die
}

pkg_postinst() {
	update_gtk_immodules

	gnome2_pkg_postinst
	elog
	elog "This version of im-ja comes with experimental XIM support."
	elog "If you'd like to try it out, run im-ja-xim-server and set"
	elog "environment variable XMODIFIERS to @im=im-ja-xim-server"
	elog "e.g.)"
	elog "\t$ export XMODIFIERS=@im=im-ja-xim-server (sh)"
	elog "\t> setenv XMODIFIERS @im=im-ja-xim-server (csh)"
	elog
}

pkg_postrm() {
	update_gtk_immodules

	gnome2_pkg_postrm
}
