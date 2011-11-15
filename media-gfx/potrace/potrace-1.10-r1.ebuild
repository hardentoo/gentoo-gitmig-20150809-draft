# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/potrace/potrace-1.10-r1.ebuild,v 1.1 2011/11/15 21:37:36 radhermit Exp $

EAPI="4"

inherit autotools-utils

DESCRIPTION="Transforming bitmaps into vector graphics"
HOMEPAGE="http://potrace.sourceforge.net/"
SRC_URI="http://potrace.sourceforge.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="metric static-libs"

DOCS=( AUTHORS ChangeLog NEWS README )

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}"

src_configure() {
	econf \
		--docdir=/usr/share/doc/${PF} \
		--enable-zlib \
		--with-libpotrace \
		$(use_enable metric a4) \
		$(use_enable metric) \
		$(use_enable static-libs static)
}
