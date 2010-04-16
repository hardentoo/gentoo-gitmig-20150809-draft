# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/visual/visual-5.1.3.ebuild,v 1.5 2010/04/16 12:37:19 hwoarang Exp $

EAPI="2"
PYTHON_DEPEND="2"

inherit eutils python flag-o-matic versionator

MY_P="${PN}-$(delete_version_separator 2)_release"

DESCRIPTION="Real-time 3D graphics library for Python"
HOMEPAGE="http://www.vpython.org/"
SRC_URI="http://www.vpython.org/contents/download/${MY_P}.tar.bz2"

IUSE="doc examples"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
LICENSE="visual"

RDEPEND=">=dev-libs/boost-1.41.0[python]
	dev-cpp/libglademm
	>=dev-cpp/gtkglextmm-1.2
	dev-python/numpy"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_configure() {
	BOOST_PKG="$(best_version ">=dev-libs/boost-1.41.0")"
	BOOST_VER="$(get_version_component_range 1-2 "${BOOST_PKG/*boost-/}")"
	BOOST_VER="$(replace_all_version_separators _ "${BOOST_VER}")"
	BOOST_INC="/usr/include/boost-${BOOST_VER}"
	BOOST_LIB="/usr/$(get_libdir)/boost-${BOOST_VER}"

	#We have to use a hack here because the build system doesn't provide a way to specify
	#the include and lib directory for boost
	append-cxxflags -I${BOOST_INC}
	append-ldflags  -L${BOOST_LIB}

	econf \
		--with-html-dir=/usr/share/doc/${PF}/html \
		--with-example-dir=/usr/share/doc/${PF}/examples \
		$(use_enable doc docs) \
		$(use_enable examples)
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc authors.txt HACKING.txt NEWS.txt

	# Don't install useless vpython script.
	rm -fr "${D}/usr/bin"
}
