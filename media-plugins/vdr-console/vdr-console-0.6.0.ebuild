# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-console/vdr-console-0.6.0.ebuild,v 1.1 2005/10/08 21:15:12 zzam Exp $

inherit vdr-plugin

IUSE=""
SLOT="0"

DESCRIPTION="vdr Plugin: Shows linux console on vdr\'s output device"
HOMEPAGE="http://ricomp.de/vdr/"
SRC_URI="http://ricomp.de/vdr/${P}.tgz"
LICENSE="GPL-2"

KEYWORDS="~x86"

DEPEND=">=media-video/vdr-1.3.7"

src_unpack() {
	vdr-plugin_src_unpack

	if has_version ">=media-video/vdr-1.3.18"; then
		cd "${S}"
		epatch ${FILESDIR}/${P}-vdr-1.3.18.diff
	fi
}
