# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp/gimp-2.0.4.ebuild,v 1.1 2004/08/11 18:04:04 lu_zero Exp $

inherit flag-o-matic libtool eutils
IUSE="X aalib altivec debug doc gimpprint gtkhtml jpeg mmx mng png python sse svg tiff wmf"
DESCRIPTION="GNU Image Manipulation Program"
P_HELP="gimp-help-${PV/\./-}"
S_HELP="$WORKDIR/${P_HELP}"
SRC_URI="mirror://gimp/v2.0/${P}.tar.bz2
		 doc? ( mirror://gimp/help/testing/${P_HELP}.tar.gz )"
HOMEPAGE="http://www.gimp.org/"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~hppa ~sparc ~amd64 ~mips ppc64"

# FIXME : some more things can be (local) USE flagged
# a few options are detection only, fix them to switch

RDEPEND=">=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.2.2
	>=x11-libs/pango-1.2.2
	>=media-libs/fontconfig-2.2
	>=media-libs/libart_lgpl-2.3.8-r1
	sys-libs/zlib

	gimpprint? ( =media-gfx/gimp-print-4.2* )
	gtkhtml? ( =gnome-extra/libgtkhtml-2* )

	png? ( >=media-libs/libpng-1.2.1 )
	jpeg? ( >=media-libs/jpeg-6b-r2
		media-libs/libexif )
	tiff? ( >=media-libs/tiff-3.5.7 )
	mng? ( media-libs/libmng )

	wmf? ( >=media-libs/libwmf-0.2.8 )
	svg? ( >=gnome-base/librsvg-2.2 )

	aalib?	( media-libs/aalib )
	python?	( >=dev-lang/python-2.2
		>=dev-python/pygtk-2 )
	X? ( virtual/x11 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	dev-util/intltool
	doc? ( >=dev-util/gtk-doc-1 )"

src_unpack() {

	unpack ${A}

	cd ${S}
	# Fix linking to older version of gimp if installed - this should
	# void liquidx's hack, so it is removed.
	epatch ${FILESDIR}/ltmain_sh-1.5.0-fix-relink.patch

}

gimp_help_compile(){
	cd ${S_HELP}
	econf || die
	emake || die
}

gimp_help_install(){
	cd ${S_HELP}
	make DESTDIR=${D} install || die
}

src_compile() {

	# Since 1.3.16, fixes linker problems when upgrading
	elibtoolize

	# Workaround portage variable leakage
	local AA=

	replace-flags "-march=k6*" "-march=i586"
	# gimp uses inline functions (plug-ins/common/grid.c) (#23078)
	filter-flags "-fno-inline"

	econf \
		--disable-default-binary \
		`use_enable mmx` \
		`use_enable sse` \
		`use_enable altivec` \
		`use_enable doc gtk-doc` \
		`use_enable python` \
		`use_enable gimpprint print` \
		`use_with X x` \
		`use_with png libpng` \
		`use_with jpeg libjpeg` \
		`use_with jpeg libexif` \
		`use_with tiff libtiff` \
		`use_with mng libmng` \
		`use_with aalib aa` \
		`use_enable debug` || die

	emake || die

	use doc && gimp_help_compile

}

src_install() {

	# Workaround portage variable leakage
	local AA=

	# create these dirs to make the makefile installs these items correctly
	dodir /usr/share/{applications,application-registry,mime-info}

	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeL* HACKING INSTALL \
		MAINTAINERS NEWS PLUGIN_MAINTAINERS README* TODO*
	use doc && gimp_help_install
}
