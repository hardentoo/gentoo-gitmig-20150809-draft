# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/luatex/luatex-0.29.0.ebuild,v 1.4 2008/09/23 20:46:08 armin76 Exp $

inherit libtool multilib eutils toolchain-funcs

PATCHLEVEL="1"

DESCRIPTION="An extended version of pdfTeX using Lua as an embedded scripting language."
HOMEPAGE="http://www.luatex.org/"
SRC_URI="http://foundry.supelec.fr/frs/download.php/664/${PN}-beta-${PV}.tar.bz2
	mirror://gentoo/${PN}-patches-${PATCHLEVEL}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc64 ~x86 ~x86-fbsd"
IUSE="doc"

RDEPEND="dev-tex/mplib
	dev-libs/zziplib
	media-libs/libpng
	app-text/poppler
	sys-libs/zlib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${PN}-beta-${PV}/src"

pkg_setup() {
	if ! built_with_use dev-tex/mplib lua ; then
		eerror "You need to build dev-tex/mplib with the lua useflag"
		eerror "${PN} requires mplib's lua bindings."
		die "Please install dev-tex/mplib with the lua useflag"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	EPATCH_SUFFIX="patch" epatch "${WORKDIR}/patches"
	elibtoolize
}

src_compile() {
	tc-export CC CXX AR RANLIB
	export NATIVE='.'
	mkdir -p "${WORKDIR}/${PN}-beta-${PV}/build"
	cd "${WORKDIR}/${PN}-beta-${PV}/build"
	ECONF_SOURCE="${S}" econf \
		--without-cxx-runtime-hack \
		--without-aleph     \
		--without-bibtex8   \
		--without-cjkutils  \
		--without-detex     \
		--without-dialog    \
		--without-dtl       \
		--without-dvi2tty   \
		--without-dvidvi    \
		--without-dviljk    \
		--without-dvipdfm   \
		--without-dvipdfmx  \
		--without-dvipng    \
		--without-dvipos    \
		--without-dvipsk    \
		--without-etex      \
		--without-gsftopk   \
		--without-lacheck   \
		--without-lcdf-typetools  \
		--without-makeindexk      \
		--without-mkocp-default   \
		--without-mkofm-default   \
		--without-musixflx  \
		--without-omega     \
		--without-pdfopen   \
		--without-ps2eps    \
		--without-ps2pkm    \
		--without-psutils   \
		--without-sam2p     \
		--without-seetexk   \
		--without-t1utils   \
		--without-tetex     \
		--without-tex4htk   \
		--without-texi2html \
		--without-texinfo   \
		--without-texlive   \
		--without-ttf2pk    \
		--without-tth       \
		--without-xdv2pdf   \
		--without-xdvik     \
		--without-xdvipdfmx \
		--without-xetex     \
		--disable-largefile \
		--with-system-zlib \
		--with-system-pnglib

	cd "${WORKDIR}/${PN}-beta-${PV}/build/texk/web2c"
	emake \
		LIBMPLIBDEP="/usr/$(get_libdir)/libmplib/mplib.la" \
		LDZZIPLIB="$(pkg-config --libs zziplib)" ZZIPLIBINC="$(pkg-config --cflags zziplib)" \
		LIBXPDFDEP="" LDLIBXPDF="$(pkg-config --libs poppler)" \
		LIBXPDFINCLUDE="$(pkg-config --cflags poppler)"	LIBXPDFCPPFLAGS="$(pkg-config --cflags poppler)" \
		LIBPNGINCLUDES="$(pkg-config --cflags libpng)" \
		ZLIBSRCDIR="." \
		luatex || die "failed to build luatex"
}

src_install() {
	cd "${WORKDIR}/${PN}-beta-${PV}/build/texk/web2c"
	emake bindir="${D}/usr/bin" \
		LIBMPLIBDEP="/usr/$(get_libdir)/libmplib/mplib.la" \
		LDZZIPLIB="$(pkg-config --libs zziplib)" ZZIPLIBINC="$(pkg-config --cflags zziplib)" \
		LIBXPDFDEP="" LDLIBXPDF="$(pkg-config --libs poppler)" \
		LIBXPDFINCLUDE="$(pkg-config --cflags poppler)"	LIBXPDFCPPFLAGS="$(pkg-config --cflags poppler)" \
		LIBPNGINCLUDES="$(pkg-config --cflags libpng)" \
		ZLIBSRCDIR="." \
		install-luatex || die "install-luatex failed"

	dodoc "${WORKDIR}/${PN}-beta-${PV}/README"
	if use doc ; then
		insinto /usr/share/doc/${PF}
		doins "${WORKDIR}/${PN}-beta-${PV}/manual/"*.pdf
	fi
}

pkg_postinst() {
	if ! has_version '>=dev-texlive/texlive-basic-2008' ; then
		elog "Please note that this package does not install much files, mainly the"
		elog "${PN} executable that will need other files in order to be useful.."
		elog "Please consider installing a recent TeX distribution"
		elog "like TeX Live 2008 to get the full power of ${PN}"
	fi
}
