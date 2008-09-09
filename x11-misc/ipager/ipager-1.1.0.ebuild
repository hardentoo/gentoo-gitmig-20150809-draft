# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/ipager/ipager-1.1.0.ebuild,v 1.3 2008/09/09 03:58:16 robbat2 Exp $

inherit eutils

DESCRIPTION="A themable desktop pager for fluxbox and other window managers"
HOMEPAGE="http://www.useperl.ru/ipager/index.en.html"
SRC_URI="http://www.useperl.ru/ipager/src/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="xinerama"

RDEPEND="media-libs/imlib2
		x11-libs/libXmu
		xinerama? ( x11-libs/libXinerama )"
DEPEND="dev-util/scons
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-scons_imlib2.patch
	epatch "${FILESDIR}"/${P}-gcc43.patch
	epatch "${FILESDIR}"/${P}-scons_flags.patch
}

src_compile() {
	CONFIG_OPTS="xinerama=false"
	use xinerama && CONFIG_OPTS="${CONFIG_OPTS} xinerama=true"
	# FYI: Passing debug=true only adds -ggdb inside the SConstruct

	scons \
		--cache-disable \
		PREFIX="/usr" \
		${CONFIG_OPTS} \
		|| die "scons configure failed"
}

src_install() {
	scons \
		--cache-disable \
		PREFIX="/usr" \
		DESTDIR="${D}" \
		install \
		|| die "scons install failed"
	dodoc ToDo ChangeLog README
	dodoc themes/*.conf
}
