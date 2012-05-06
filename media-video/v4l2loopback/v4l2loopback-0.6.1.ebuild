# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/v4l2loopback/v4l2loopback-0.6.1.ebuild,v 1.1 2012/05/06 06:49:55 naota Exp $

EAPI=4

inherit linux-mod vcs-snapshot

DESCRIPTION="v4l2 loopback device which output is it's own input"
HOMEPAGE="https://github.com/umlaeute/v4l2loopback"
SRC_URI="https://github.com/umlaeute/v4l2loopback/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CONFIG_CHECK="VIDEO_DEV"
MODULE_NAMES="v4l2loopback(video:)"
BUILD_TARGETS="all"

DEPEND=""
RDEPEND="${DEPEND}"
