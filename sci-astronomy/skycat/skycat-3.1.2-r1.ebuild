# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/skycat/skycat-3.1.2-r1.ebuild,v 1.1 2011/08/23 11:48:46 xarthisius Exp $

EAPI=4
inherit eutils autotools

DESCRIPTION="ESO astronomical image visualizer with catalog access."
HOMEPAGE="http://archive.eso.org/skycat"
SRC_URI="http://archive.eso.org/cms/tools-documentation/skycat-download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="threads"

DEPEND="x11-libs/libXext
	>=dev-tcltk/tclx-2.4
	>=dev-tcltk/blt-2.4
	>=dev-tcltk/itcl-3.3
	>=dev-tcltk/iwidgets-4.0.1
	>=dev-tcltk/tkimg-1.3
	sci-libs/cfitsio
	sci-astronomy/wcstools"
RDEPEND="${DEPEND}"

src_prepare() {
	# fix buggy tcl.m4 for bash3 and add soname
	epatch "${FILESDIR}"/${P}-m4.patch
	# need fix for tk-8.5
	if has_version ">=dev-lang/tk-8.5" ; then
		epatch "${FILESDIR}"/${PN}-3.0.2-tk8.5.patch
	fi
	epatch "${FILESDIR}"/${P}-makefile-qa.patch
	# use system libs
	epatch "${FILESDIR}"/${PN}-3.0.2-systemlibs.patch
	rm -fr astrotcl/{cfitsio,libwcs} \
		|| die "Failed to remove included libs"
	eautoreconf
}

src_configure() {
	econf $(use_enable threads) --enable-merge
}

src_install() {
	default
	local d
	for d in tclutil astrotcl rtd cat skycat; do
		for f in README CHANGES VERSION; do
			newdoc ${f} ${f}.${d}
		done
	done
}
