# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libvorbis/libvorbis-1.1.0.ebuild,v 1.21 2006/10/04 17:40:32 grobian Exp $

inherit libtool flag-o-matic eutils toolchain-funcs

DESCRIPTION="the Ogg Vorbis sound file format library"
HOMEPAGE="http://www.xiph.org/ogg/vorbis/index.html"
SRC_URI="http://downloads.xiph.org/releases/vorbis/${P}.tar.gz
		aotuv? ( mirror://gentoo/libvorbis-aotuv-b3.patch )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86"
IUSE="aotuv"

RDEPEND=">=media-libs/libogg-1.0"
DEPEND="${RDEPEND}
	sys-apps/sed"

S=${WORKDIR}/${P/_*/}

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}

	use aotuv && epatch ${DISTDIR}/libvorbis-aotuv-b3.patch

	# Fix a gcc crash.  With the new atexit patch to gcc, it
	# seems it does not handle -mno-ieee-fp very well.
	sed -i -e "s:-mno-ieee-fp::g" configure

	elibtoolize

	epunt_cxx #74493
}

src_compile() {
	# Cannot compile with sse2 support it would seem #36104
	use x86 && [ $(gcc-major-version) -eq 3 ] && append-flags -mno-sse2
	[ "`gcc-version`" == "3.4" ] && replace-flags -Os -O2

	# take out -fomit-frame-pointer from CFLAGS if k6-2
	is-flag -march=k6-3 && filter-flags -fomit-frame-pointer
	is-flag -march=k6-2 && filter-flags -fomit-frame-pointer
	is-flag -march=k6 && filter-flags -fomit-frame-pointer

	# over optimization causes horrible audio artifacts #26463
	filter-flags -march=pentium?

	# gcc-3.4 and k6 with -ftracer causes code generation problems #49472
	if [ $(gcc-major-version) -eq 3 -a $(gcc-minor-version) -eq 4 ];
	then
		is-flag -march=k6* && filter-flags -ftracer
		is-flag -mtune=k6* && filter-flags -ftracer
	fi

	# gcc on hppa causes issues when assembling
	use hppa && replace-flags -march=2.0 -march=1.0

	# Make prelink work properly
	append-flags -fPIC
	append-ldflags -fPIC

	econf || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dosym libvorbisfile.so.3.1.0 /usr/$(get_libdir)/libvorbisfile.so.0
	dosym libvorbisenc.so.2.0.0 /usr/$(get_libdir)/libvorbisenc.so.0

	rm -rf ${D}/usr/share/doc
	dodoc AUTHORS README todo.txt
	docinto txt
	dodoc doc/*.txt
	dohtml -r doc
}
