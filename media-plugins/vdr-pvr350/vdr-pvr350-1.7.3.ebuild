# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-pvr350/vdr-pvr350-1.7.3.ebuild,v 1.2 2012/06/27 17:36:59 hd_brummy Exp $

EAPI="4"

inherit vdr-plugin-2

VERSION="995"

DESCRIPTION="VDR plugin: use a PVR350 as output device"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-pvr350"
SRC_URI="mirror://vdrdeveloper-org/${VERSION}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="yaepg"

DEPEND=">=media-video/vdr-1.6.0
	media-sound/mpg123
	media-sound/twolame
	media-libs/a52dec
	yaepg? ( >=media-video/vdr-1.6.0[yaepg] )"
RDEPEND="${DEPEND}"

DEPEND="${DEPEND}
	|| ( >=sys-kernel/linux-headers-2.6.38 )"

S="${WORKDIR}/${P#vdr-}"

pkg_setup() {
	vdr-plugin-2_pkg_setup

	if use yaepg; then
		BUILD_PARAMS="SET_VIDEO_WINDOW=1"
	fi
}
