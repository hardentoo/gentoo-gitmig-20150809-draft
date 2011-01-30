# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-kvdrmon/vdr-kvdrmon-0.6.ebuild,v 1.3 2011/01/30 00:17:19 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin

DESCRIPTION="VDR Plugin: monitors on KDE Kickerapplet kvdrmon"
HOMEPAGE="http://vdr-statusleds.sf.net/kvdrmon"
SRC_URI="mirror://sourceforge/vdr-statusleds/${P}.tgz"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.3.0"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-remove-menu-entry.diff" )
