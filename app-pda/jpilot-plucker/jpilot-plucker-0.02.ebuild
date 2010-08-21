# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/jpilot-plucker/jpilot-plucker-0.02.ebuild,v 1.2 2010/08/21 14:13:14 tomjbe Exp $

EAPI=2
inherit multilib

DESCRIPTION="Plucker plugin for jpilot"
HOMEPAGE="http://www.jlogday.com/code/jpilot-plucker/index.html"
SRC_URI="http://www.jlogday.com/code/jpilot-plucker/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.18.9
	>=app-pda/pilot-link-0.12.3
	>=app-pda/jpilot-0.99.7-r1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		--enable-gtk2
}

src_install() {
	emake \
		DESTDIR="${D}" \
		libdir="/usr/$(get_libdir)/jpilot/plugins" \
		install || die

	dodoc AUTHORS ChangeLog README TODO

	find "${D}" -name '*.la' -delete
}
