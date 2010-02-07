# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pngrewrite/pngrewrite-1.3.0.ebuild,v 1.8 2010/02/07 16:07:00 armin76 Exp $

inherit toolchain-funcs base

DESCRIPTION="A utility which reduces large palettes in PNG images"
HOMEPAGE="http://entropymine.com/jason/pngrewrite/"
SRC_URI="http://entropymine.com/jason/${PN}/${P}.zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86 ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND="media-libs/libpng"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}
PATCHES=( "${FILESDIR}"/${P}-gcc44.patch )

src_compile() {
	$(tc-getCC) ${LDFLAGS} ${CFLAGS} ${PN}.c -lpng -o ${PN} \
		|| die "compile failed."
}

src_install() {
	dobin ${PN} || die "dobin failed."
}
