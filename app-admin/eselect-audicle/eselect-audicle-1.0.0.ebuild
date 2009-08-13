# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-audicle/eselect-audicle-1.0.0.ebuild,v 1.1 2009/08/13 21:30:41 cedk Exp $

DESCRIPTION="Manages the /usr/bin/audicle symlink"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/audicle.eselect-${PVR}.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-admin/eselect-1.0.6"

src_install() {
	insinto /usr/share/eselect/modules
	newins "${WORKDIR}/audicle.eselect-${PVR}" audicle.eselect || die
}
