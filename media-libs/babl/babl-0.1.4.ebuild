# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/babl/babl-0.1.4.ebuild,v 1.10 2011/04/23 17:57:34 armin76 Exp $

EAPI=3

DESCRIPTION="A dynamic, any to any, pixel format conversion library"
HOMEPAGE="http://www.gegl.org/babl/"
SRC_URI="ftp://ftp.gimp.org/pub/${PN}/${PV:0:3}/${P}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~ppc ~ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="altivec +introspection sse mmx"

RDEPEND="introspection? ( >=dev-libs/gobject-introspection-0.6.8 )"
DEPEND="${RDEPEND}"

src_configure() {
	# Automagic rsvg support is just for website generation we do not call,
	#     so we don't need to fix it
	# w3m is used for dist target thus no issue for us that it is automagically
	#     detected
	econf \
		--disable-static \
		--disable-maintainer-mode \
		$(use_enable altivec) \
		$(use_enable introspection) \
		$(use_enable mmx) \
		$(use_enable sse)
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	find "${ED}" -name '*.la' -delete
	dodoc AUTHORS ChangeLog README NEWS || die "dodoc failed"
}
