# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/tunepimp/tunepimp-0.5.3-r2.ebuild,v 1.2 2009/07/10 12:49:06 ssuominen Exp $

EAPI="1"

inherit eutils distutils autotools

MY_P="lib${P}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="TunePimp is a library to create MusicBrainz enabled tagging applications."
HOMEPAGE="http://www.musicbrainz.org/products/tunepimp"
SRC_URI="http://ftp.musicbrainz.org/pub/musicbrainz/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
# Most use flags were void as not deterministic - needs a patch sooner or later.
#IUSE="flac mp3 readline perl python vorbis"
IUSE="python"

RDEPEND="sys-libs/zlib
	dev-libs/expat
	net-misc/curl
	>=media-libs/flac-1.1.2
	media-libs/libmad
	>=media-libs/musicbrainz-2.1.0:1
	media-libs/libmp4v2
	media-libs/libofa
	media-libs/libvorbis
	!media-sound/trm
	sys-libs/readline"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

# parallel build is broken - https://bugs.gentoo.org/204174
MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch \
		"${FILESDIR}/${P}-gcc43.patch" \
		"${FILESDIR}/${P}-libtool.patch" \
		"${FILESDIR}/${P}-build-fix.patch" \
		"${FILESDIR}/${P}-gcc44.patch"

	sed -i -e "s: tta::" configure.in

	if has_version ">=media-libs/libmp4v2-1.9.0"; then
		epatch "${FILESDIR}"/${P}-new_libmp4v2.patch
	fi

	eautoreconf
}

src_compile() {
	# We need to override distutils_src_compile, bug 160145
	econf || die 'econf failed'
	emake || die 'emake failed'
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL README TODO || die "installing docs failed"

	if use python; then
		cd "${S}/python"
		distutils_src_install
		insinto /usr/share/doc/${PF}/examples/
		doins examples/* || die "installing examples failed"
	fi
}
