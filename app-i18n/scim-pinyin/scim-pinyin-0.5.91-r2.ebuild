# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-pinyin/scim-pinyin-0.5.91-r2.ebuild,v 1.6 2009/11/25 19:32:03 ssuominen Exp $

inherit eutils autotools

DESCRIPTION="Smart Common Input Method (SCIM) Smart Pinyin Input Method"
HOMEPAGE="http://www.scim-im.org/"
SRC_URI="mirror://sourceforge/scim/${P}.tar.gz"

IUSE="nls"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc64 sparc"

RDEPEND="x11-libs/libXt
	|| ( >=app-i18n/scim-1.1 >=app-i18n/scim-cvs-1.1 )
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-fixconfigure.patch"
	epatch "${FILESDIR}/${PN}-qt335.patch"
	epatch "${FILESDIR}/${P}-gcc43.patch"

	AT_M4DIR=m4 AT_NO_RECURSIVE=yes eautoreconf
}

src_compile() {
	econf \
		$(use_enable nls) \
		--disable-skim-support \
		--without-arts \
		--disable-static \
		--disable-depedency-tracking \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHROS NEWS README ChangeLog
}
