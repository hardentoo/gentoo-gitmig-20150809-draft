# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-neon/gst-plugins-neon-0.10.4.ebuild,v 1.1 2007/01/25 20:07:58 lack Exp $

inherit gst-plugins-bad

KEYWORDS="~amd64 ~x86"

RDEPEND=">=net-misc/neon-0.25.5
		>=media-libs/gstreamer-0.10.10
		>=media-libs/gst-plugins-base-0.10.10.1"

DEPEND="${RDEPEND}"

