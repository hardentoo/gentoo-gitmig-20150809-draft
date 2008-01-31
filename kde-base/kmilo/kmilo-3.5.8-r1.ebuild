# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmilo/kmilo-3.5.8-r1.ebuild,v 1.6 2008/01/31 15:30:50 ranger Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kmilo - a kded module that can be extended to support various types of hardware
input devices that exist, such as those on keyboards."
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility pbbuttonsd"
DEPEND="pbbuttonsd? ( app-laptop/pbbuttonsd )"
RDEPEND="${DEPEND}"

PATCHES="${FILESDIR}/${P}-198015_XF86Audio.patch"

src_compile() {
	local myconf="$(use_with pbbuttonsd powerbook)"

	kde-meta_src_compile
}
