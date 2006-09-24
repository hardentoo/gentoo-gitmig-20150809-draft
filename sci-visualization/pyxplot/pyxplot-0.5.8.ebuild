# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/pyxplot/pyxplot-0.5.8.ebuild,v 1.2 2006/09/24 02:13:44 dberkholz Exp $

inherit eutils python

DESCRIPTION="Graphing program similar to gnuplot to produce publication-quality figures"
HOMEPAGE="http://www.pyxplot.org.uk/"
SRC_URI="http://www.pyxplot.org.uk/src/${PN}_${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND=">=dev-python/pyx-0.9
	sci-libs/scipy
	virtual/tetex
	virtual/ghostscript
	|| ( app-text/gv app-text/ggv )
	media-gfx/imagemagick"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:^\(USRDIR=\).*:\1/usr:g" \
		-e 's:^\(MANDIR=\).*:\1${USRDIR}/share/man/man1:g' \
		-e "s:^\(DOCDIR=\).*:\1\${USRDIR}/share/doc/${PF}:g" \
		"${S}"/Makefile.skel
	epatch "${FILESDIR}"/${PV}-dont-build-pyx.patch
	# Depends on dont-build-pyx.patch
	epatch "${FILESDIR}"/${PV}-respect-destdir.patch

	# It doesn't come with precompiled .pyc files,
	# so fails if we try to install them.
	sed -i \
		-e "/pyc/d" \
		"${S}"/Makefile.skel
}

src_compile() {
	# latex...
	addwrite /var/cache/fonts

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README AUTHORS ChangeLog
}

pkg_postinst() {
	python_mod_optimize ${ROOT}usr/share/pyxplot
}

pkg_postrm() {
	python_mod_cleanup ${ROOT}usr/share/pyxplot
}
