# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-cdparanoia/gst-plugins-cdparanoia-0.10.25.ebuild,v 1.5 2010/04/18 15:39:09 nixnut Exp $

inherit gst-plugins-base

KEYWORDS="alpha amd64 ~hppa ia64 ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND=">=media-sound/cdparanoia-3.10.2-r3"
DEPEND="${RDEPEND}"
