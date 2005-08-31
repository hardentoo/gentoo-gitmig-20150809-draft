# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-v4l/gst-plugins-v4l-0.8.10.ebuild,v 1.3 2005/08/31 22:24:06 herbs Exp $

inherit gst-plugins

DESCRIPION="plugin to allow capture from video4linux1 devices"

KEYWORDS="amd64 ~ppc x86"

IUSE=""

RDEPEND="virtual/x11"

DEPEND="${RDEPEND}
	virtual/os-headers
	>=dev-util/pkgconfig-0.9"

