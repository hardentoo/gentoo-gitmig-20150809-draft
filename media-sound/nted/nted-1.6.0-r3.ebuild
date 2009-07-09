# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/nted/nted-1.6.0-r3.ebuild,v 1.1 2009/07/09 20:57:01 hwoarang Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="WYSIWYG score editor for GTK+2"
HOMEPAGE="http://vsr.informatik.tu-chemnitz.de/staff/jan/nted/nted.xhtml"
SRC_URI="http://vsr.informatik.tu-chemnitz.de/staff/jan/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc nls debug"
RDEPEND="doc? ( gnome-extra/yelp app-text/xmlto )
	x11-libs/cairo
	x11-libs/gtk+:2
	media-libs/alsa-lib"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}/${PN}.desktop.patch"
	epatch "${FILESDIR}/${P}-time-signature.patch"
	epatch "${FILESDIR}/makefile_am_ldflags.patch"
	eautoreconf
}

src_configure() {
	econf $(use_with doc) \
	$(use_enable debug) \
	$(use_enable nls) || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ABOUT_* ChangeLog FAQ NEWS README || die "dodoc failed"
	doman "man/${PN}.1" || die "doman failed"
}
