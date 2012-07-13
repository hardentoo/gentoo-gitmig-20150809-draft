# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/ldns/ldns-1.6.13.ebuild,v 1.2 2012/07/13 13:30:26 darkside Exp $

EAPI="4"
PYTHON_DEPEND="python? 2:2.5"

inherit autotools eutils python

DESCRIPTION="ldns is a library with the aim to simplify DNS programing in C"
HOMEPAGE="http://www.nlnetlabs.nl/projects/ldns/"
SRC_URI="http://www.nlnetlabs.nl/downloads/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc-macos ~x64-macos"
IUSE="doc gost +ecdsa python +ssl static-libs vim-syntax"

RESTRICT="test" # 1.6.9 has no test directory

RDEPEND="ssl? ( >=dev-libs/openssl-0.9.7 )
	ecdsa? ( >=dev-libs/openssl-0.9.8 )
	gost? ( >=dev-libs/openssl-1 )"
DEPEND="${RDEPEND}
	python? ( dev-lang/swig )
	doc? ( app-doc/doxygen )"

# configure will die if ecdsa is enabled and ssl is not
REQUIRED_USE="ecdsa? ( ssl )"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/1.6.12-cflags.patch"

	eautoreconf
}

src_configure() {
	econf \
		$(use_enable ecdsa) \
		$(use_enable gost) \
		$(use_enable ssl sha2) \
		$(use_enable static-libs static) \
		$(use_with ssl) \
		$(use_with python pyldns) \
		$(use_with python pyldnsx) \
		--without-drill \
		--without-examples \
		--disable-rpath
}

src_compile() {
	default

	if use doc ; then
		emake doxygen
	fi
}

src_install() {
	default

	dodoc Changelog README*

	if use python ; then
		find "${ED}$(python_get_sitedir)" "(" -name "*.a" -o -name "*.la" ")" -type f -delete || die
	fi

	if ! use static-libs ; then
		find "${ED}" -name "*.la" -type f -delete || die
	fi

	if use doc ; then
		dohtml doc/html/*
	fi

	if use vim-syntax ; then
		insinto /usr/share/vim/vimfiles/ftdetect
		doins libdns.vim
	fi

	einfo
	elog "Install net-dns/ldns-utils if you want drill and examples"
	einfo
}
