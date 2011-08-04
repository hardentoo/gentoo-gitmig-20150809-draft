# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/libwpg/libwpg-0.1.3.ebuild,v 1.1 2011/08/04 16:25:30 scarabeus Exp $

inherit base eutils

DESCRIPTION="C++ library to read and parse graphics in WPG"
HOMEPAGE="http://libwpg.sourceforge.net/libwpg.htm"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0.1"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="doc"

RDEPEND=">=app-text/libwpd-0.8.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

src_compile() {
	econf \
		--disable-dependency-tracking \
		$(use_with doc docs)
	emake || die "emake failed"
}
