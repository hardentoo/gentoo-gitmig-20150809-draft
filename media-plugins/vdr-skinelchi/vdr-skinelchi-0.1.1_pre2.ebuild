# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-skinelchi/vdr-skinelchi-0.1.1_pre2.ebuild,v 1.2 2006/08/07 12:48:54 zzam Exp $

inherit vdr-plugin

MY_P=${P/_pre/pre}

DESCRIPTION="Video Disk Recorder - Skin Plugin"
HOMEPAGE="http://www.vdrportal.de/board/thread.php?threadid=41915&sid="
SRC_URI="mirror://gentoo/${MY_P}.tgz http://dev.gentoo.org/~zzam/distfiles/${MY_P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 x86"
IUSE="imagemagick"

DEPEND=">=media-video/vdr-1.3.22
		imagemagick? ( media-gfx/imagemagick )"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P#vdr-}

src_unpack() {
	vdr-plugin_src_unpack

	if use imagemagick; then
		einfo "Enabling imagemagick-support."
		sed -i ${S}/Makefile -e 's/^#HAVE_IMAGEMAGICK/HAVE_IMAGEMAGICK/'
	fi
}

