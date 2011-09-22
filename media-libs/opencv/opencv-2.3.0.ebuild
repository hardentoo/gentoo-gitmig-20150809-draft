# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/opencv/opencv-2.3.0.ebuild,v 1.3 2011/09/22 20:03:55 dilfridge Exp $

EAPI=3

PYTHON_DEPEND="python? 2:2.6"

inherit base cmake-utils fortran-2 python

MY_P=OpenCV-${PV}

DESCRIPTION="A collection of algorithms and sample code for various computer vision problems"
HOMEPAGE="http://opencv.willowgarage.com"
SRC_URI="mirror://sourceforge/${PN}library/${MY_P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="cuda doc eigen examples ffmpeg gstreamer gtk ieee1394 ipp jpeg jpeg2k openexr opengl png python qt4 sse sse2 sse3 ssse3 tiff v4l xine"

RDEPEND="
	app-arch/bzip2
	sys-libs/zlib
	sci-libs/flann
	cuda? ( >=dev-util/nvidia-cuda-toolkit-4 )
	eigen? ( dev-cpp/eigen:2 )
	ffmpeg? ( virtual/ffmpeg )
	gstreamer? (
		media-libs/gstreamer
		media-libs/gst-plugins-base
	)
	gtk? (
		dev-libs/glib:2
		x11-libs/gtk+:2
	)
	jpeg? ( virtual/jpeg )
	jpeg2k? ( media-libs/jasper )
	ieee1394? ( media-libs/libdc1394 sys-libs/libraw1394 )
	ipp? ( sci-libs/ipp )
	openexr? ( media-libs/openexr )
	png? ( media-libs/libpng )
	python? ( dev-python/numpy )
	qt4? (
		x11-libs/qt-gui:4
		opengl? ( x11-libs/qt-opengl:4 )
	)
	tiff? ( media-libs/tiff )
	v4l? ( >=media-libs/libv4l-0.8.3 )
	xine? ( media-libs/xine-lib )
"
DEPEND="${RDEPEND}
	doc? ( virtual/latex-base )
	dev-util/pkgconfig
"

# REQUIRED_USE="opengl? ( qt )"

PATCHES=(
	"${FILESDIR}/${PN}-2.3.0-convert_sets_to_options.patch"
	"${FILESDIR}/${PN}-2.3.0-ffmpeg.patch"
	"${FILESDIR}/${PN}-2.3.0-numpy.patch"
	"${FILESDIR}/${PN}-2.3.0-symlink.patch"
)

CMAKE_BUILD_TYPE="Release"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	fortran-2_pkg_setup
	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	base_src_prepare
	# include missing zlib.h for libpng>1.5. Bug #383571
	epatch "${FILESDIR}"/${P}-libpng15.patch

	# remove bundled stuff
	rm -rf 3rdparty
	sed -i \
		-e '/add_subdirectory(3rdparty)/ d' \
		CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build doc DOCS)
		$(cmake-utils_use_build examples)
		$(cmake-utils_use examples INSTALL_C_EXAMPLES)
		$(cmake-utils_use_build python NEW_PYTHON_SUPPORT)
		$(cmake-utils_use_enable sse SSE)
		$(cmake-utils_use_enable sse2 SSE2)
		$(cmake-utils_use_enable sse3 SSE3)
		$(cmake-utils_use_enable ssse3 SSSE3)
		$(cmake-utils_use_with ipp)
		$(cmake-utils_use_with ieee1394 1394)
		$(cmake-utils_use_with cuda)
		$(cmake-utils_use_with eigen)
		$(cmake-utils_use_with ffmpeg)
		$(cmake-utils_use_with gstreamer)
		$(cmake-utils_use_with gtk)
		$(cmake-utils_use_with jpeg)
		$(cmake-utils_use_with jpeg2k JASPER)
		$(cmake-utils_use_with openexr)
		$(cmake-utils_use_with png)
		$(cmake-utils_use_with qt4 QT)
		$(cmake-utils_use_with opengl QT_OPENGL)
		$(cmake-utils_use_with tiff)
		$(cmake-utils_use_with v4l V4L)
		$(cmake-utils_use_with xine)
	)

	if use python && use examples; then
		mycmakeargs+=( "-DINSTALL_PYTHON_EXAMPLES=ON" )
	else
		mycmakeargs+=( "-DINSTALL_PYTHON_EXAMPLES=OFF" )
	fi

	# things we want to be hard off or not yet figured out
	# unicap: https://bugs.gentoo.org/show_bug.cgi?id=175881
	# openni: ???
	mycmakeargs+=(
		"-DUSE_OMIT_FRAME_POINTER=OFF"
		"-DOPENCV_BUILD_3RDPARTY_LIBS=OFF"
		"-DOPENCV_WARNINGS_ARE_ERRORS=OFF"
		"-DBUILD_LATEX_DOCS=OFF"
		"-DENABLE_POWERPC=OFF"
		"-DBUILD_PACKAGE=OFF"
		"-DENABLE_PROFILING=OFF"
		"-DUSE_O2=OFF"
		"-DUSE_O3=OFF"
		"-DUSE_FAST_MATH=OFF"
		"-DENABLE_SSE41=OFF"
		"-DENABLE_SSE42=OFF"
		"-DWITH_PVAPI=OFF"
		"-DWITH_UNICAP=OFF"
		"-DWITH_TBB=OFF"
		"-DWITH_OPENNI=OFF"
	)

	# things we want to be hard enabled not worth useflag
	mycmakeargs+=(
		"-DCMAKE_SKIP_RPATH=ON"
		"-DBUILD_SHARED_LIBS=ON"
		"-DOPENCV_DOC_INSTALL_PATH=${EPREFIX}/usr/share/doc/${PF}"
	)

	# hardcode cuda paths
	mycmakeargs+=(
		"-DCUDA_NPP_LIBRARY_ROOT_DIR=/opt/cuda"
	)

	cmake-utils_src_configure
}
