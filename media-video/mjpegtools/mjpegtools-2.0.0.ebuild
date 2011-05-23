# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mjpegtools/mjpegtools-2.0.0.ebuild,v 1.1 2011/05/23 20:58:40 billie Exp $

EAPI=4

inherit flag-o-matic linux-info toolchain-funcs

MY_P=${P/_/}

DESCRIPTION="Tools for MJPEG video"
HOMEPAGE="http://mjpeg.sourceforge.net/"
SRC_URI="mirror://sourceforge/mjpeg/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="dga dv gtk mmx png quicktime sdl static-libs v4l X"
REQUIRED_USE="!X? ( !gtk !sdl )
	X? ( sdl )"

RDEPEND="virtual/jpeg
	quicktime? ( media-libs/libquicktime )
	dv? ( >=media-libs/libdv-0.99 )
	png? ( media-libs/libpng )
	dga? ( x11-libs/libXxf86dga )
	X? ( x11-libs/libX11
		x11-libs/libXt
		gtk? ( x11-libs/gtk+:2 )
		sdl? ( >=media-libs/libsdl-1.2.7-r3 )
	 )"

DEPEND="${RDEPEND}
	mmx? ( dev-lang/nasm )
	>=sys-apps/sed-4
	sys-apps/gawk
	dev-util/pkgconfig"

S="${WORKDIR}/${P/_rc*}"

pkg_pretend() {
	if kernel_is ge 2 6 38 && use v4l; then
		ewarn "Current versions of mjpegtools only support V4L1 which is not available"
		ewarn "for kernels versions 2.6.38 and above. V4L1 will be disabled."
	fi
}

# Avoid execution of linux-info_pkg_setup()
pkg_setup() { : ; }

src_prepare() {
	sed -i -e '/ARCHFLAGS=/s:=.*:=:' configure
}

src_configure() {
	[[ $(gcc-major-version) -eq 3 ]] && append-flags -mno-sse2

	econf \
		--enable-compile-warnings \
		$(use_enable mmx simd-accel) \
		$(use_enable static-libs static) \
		--enable-largefile \
		$(use_with quicktime libquicktime) \
		$(use_with dv libdv) \
		$(use_with png libpng) \
		$(use_with dga) \
		$(use_with gtk) \
		$(use_with sdl libsdl) \
		$(use_with v4l) \
		$(use_with X x)
}

src_install() {
	default

	dodoc mjpeg_howto.txt PLANS HINTS docs/FAQ.txt

	find "${D}" -name '*.la' -exec rm -rf '{}' '+' || die "la removal failed"
}
