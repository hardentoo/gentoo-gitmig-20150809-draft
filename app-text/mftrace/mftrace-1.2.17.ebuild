# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mftrace/mftrace-1.2.17.ebuild,v 1.5 2011/11/16 17:28:51 chainsaw Exp $

EAPI="4"
PYTHON_DEPEND="2"

inherit python toolchain-funcs

DESCRIPTION="Traces TeX fonts to PFA or PFB fonts (formerly pktrace)"
HOMEPAGE="http://lilypond.org/mftrace/"
SRC_URI="http://lilypond.org/download/sources/mftrace/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
# SLOT 1 was used in pktrace ebuild
SLOT="1"
IUSE="test truetype"

RDEPEND=">=app-text/t1utils-1.25
	|| ( media-gfx/potrace >=media-gfx/autotrace-0.30 )
	truetype? ( media-gfx/fontforge )
	virtual/latex-base"
DEPEND="${RDEPEND}
	test? ( media-gfx/fontforge )"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_configure() {
	tc-export CC
	econf \
		--datadir="$(python_get_sitedir)" \
		PYTHON="$(PYTHON)"
}

src_compile() {
	emake CFLAGS="-Wall ${CFLAGS}"
}

src_install () {
	emake DESTDIR="${D}" PYC_MODULES="" install
	dodoc README.txt ChangeLog
}

pkg_postinst() {
	python_mod_optimize mftrace
}

pkg_postrm() {
	python_mod_cleanup mftrace
}
