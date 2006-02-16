# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice-libs/koffice-libs-1.5_beta1.ebuild,v 1.4 2006/02/16 02:20:14 weeve Exp $

MAXKOFFICEVER=${PV}
KMNAME=koffice
KMMODULE=lib
inherit kde-meta eutils

DESCRIPTION="Shared KOffice libraries."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2 LGPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~sparc ~x86"
IUSE="doc"

RDEPEND="$(deprange $PV $MAXKOFFICEVER app-office/koffice-data)
	virtual/python
	dev-lang/ruby"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	dev-util/pkgconfig"

KMEXTRA="interfaces/
	plugins/
	tools/
	filters/olefilters/
	filters/xsltfilter/
	filters/generic_wrapper/
	kounavail/
	doc/api/
	doc/koffice/
	doc/thesaurus/"

KMEXTRACTONLY="
	kchart/kdchart/"

need-kde 3.4

src_unpack() {
	kde-meta_src_unpack unpack

	# Force the compilation of libkopainter.
	sed -i 's:$(KOPAINTERDIR):kopainter:' $S/lib/Makefile.am

	kde-meta_src_unpack makefiles
}

src_compile() {
	local myconf="--enable-scripting --with-pythonfir=${ROOT}/usr/$(get_libdir)/python${PYVER}/site-packages"
	kde-meta_src_compile
	if use doc; then
		make apidox || die
	fi
}

src_install() {
	kde-meta_src_install
	if use doc; then
		make DESTDIR=${D} install-apidox || die
	fi
}
