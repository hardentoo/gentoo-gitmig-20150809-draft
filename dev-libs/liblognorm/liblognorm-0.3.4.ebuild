# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/liblognorm/liblognorm-0.3.4.ebuild,v 1.3 2012/06/02 10:42:50 ago Exp $

EAPI=4

inherit  autotools-utils

DESCRIPTION="Fast samples-based log normalization library"
HOMEPAGE="http://www.liblognorm.com"
SRC_URI="http://www.liblognorm.com/files/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~x86 ~amd64-linux"
IUSE="debug static-libs"

DEPEND="
	dev-libs/libestr
	dev-libs/libee"
RDEPEND="${DEPEND}"

src_compile() {
	autotools-utils_src_compile -j1
}
