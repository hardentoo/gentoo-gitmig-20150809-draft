# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/engauge/engauge-4.1.ebuild,v 1.4 2010/03/09 11:35:13 abcd Exp $

EAPI=2

inherit versionator qt3 eutils

DESCRIPTION="Convert an image file showing a graph or map into numbers"
HOMEPAGE="http://digitizer.sourceforge.net/"
SRC_URI="mirror://sourceforge/digitizer/digit-src-$(replace_version_separator . _).tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="doc examples"

DEPEND="x11-libs/qt:3
	sci-libs/fftw:3.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	# Some patching and using the DEBIAN_PACKAGE ifdef is necessary to make sure the
	# documentation is looked for in the proper directory
	sed -i -e "s:/usr/share/doc/engauge-digitizer-doc:${ROOT}/usr/share/doc/${PF}:" \
		src/digitmain.cpp || die "sed failed"
	sed -i -e '/unix {/a \
DEFINES += DEBIAN_PACKAGE' engauge/digitizer.pro || die "sed failed"
}

src_configure() {
	eqmake3 "${PN}"/digitizer.pro
}

serc_compile() {
	emake -DDEBIAN_PACKAGE || die "make failed"
}

src_install() {
	dobin bin/engauge
	newicon src/img/lo32-app-digitizer.png "${PN}.png"
	make_desktop_entry engauge "Engauge Digitizer" ${PN} Graphics
	use doc && dodoc -r usermanual
	use examples && dodoc -r samples
}
