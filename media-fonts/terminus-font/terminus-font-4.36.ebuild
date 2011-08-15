# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/terminus-font/terminus-font-4.36.ebuild,v 1.1 2011/08/15 11:36:53 jlec Exp $

EAPI=3

inherit eutils font

DESCRIPTION="A clean fixed font for the console and X11"
HOMEPAGE="http://terminus-font.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}/${P}.tar.gz"

LICENSE="OFL-1.1 GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="a-like-o ru-dv +ru-g quote ru-i ru-k width +psf raw-font-data +pcf"

DEPEND="dev-lang/perl
		sys-apps/gawk
		app-arch/gzip
		pcf? ( x11-apps/bdftopcf )"
RDEPEND=""

FONTDIR=/usr/share/fonts/terminus
DOCS="README README-BG AUTHORS CHANGES"

pkg_setup() {
	# Note: that pcf fonts can be loaded by freetype even if X is not installed.
	# That's why configuration +pcf and -X is supported, bug #155783.
	if use X && ! use pcf ; then
		eerror "Fonts which works with Xserver are intalled only if pcf is enabled."
		die "Either disable X use flag or enabled pcf."
	fi

	font_pkg_setup
}

src_prepare() {
	# Upstream patches. Some of them are suggested to be applied by default
	# dv - de NOT like latin g, but like caps greek delta
	#      ve NOT like greek beta, but like caps latin B
	# ge - ge NOT like "mirrored" latin s, but like caps greek gamma
	# ka - small ka NOT like minimised caps latin K, but like small latin k
	use a-like-o && epatch "${S}"/alt/ao2.diff
	use ru-i     && epatch "${S}"/alt/ij1.diff
	use ru-k     && epatch "${S}"/alt/ka2.diff
	use ru-dv    && epatch "${S}"/alt/dv1.diff
	use ru-g     && epatch "${S}"/alt/ge2.diff
	use quote    && epatch "${S}"/alt/gq2.diff
	use width    && epatch "${S}"/alt/cm2.diff
}

src_configure() {
	# selfwritten configure script
	./configure \
		--prefix="${EPREFIX}"/usr \
		--psfdir="${EPREFIX}"/usr/share/consolefonts \
		--acmdir="${EPREFIX}"/usr/share/consoletrans \
		--unidir="${EPREFIX}"/usr/share/consoletrans \
		--x11dir="${EPREFIX}"/${FONTDIR} || die
}

src_compile() {
	if use psf; then emake psf txt || die; fi
	if use raw-font-data; then emake raw || die; fi
	if use pcf; then emake pcf || die; fi
}

src_install() {
	if use psf; then
		emake DESTDIR="${D}" install-psf install-uni install-acm install-ref || die
	fi
	if use raw-font-data; then
		emake DESTDIR="${D}" install.raw || die
	fi
	if use pcf; then
		emake DESTDIR="${D}" install-pcf || die
	fi

	font_src_install
}
