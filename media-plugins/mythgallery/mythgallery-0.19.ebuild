# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythgallery/mythgallery-0.19.ebuild,v 1.1 2006/02/12 10:05:40 cardoe Exp $

inherit mythtv-plugins

DESCRIPTION="Gallery and slideshow module for MythTV."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/mythplugins-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="exif"

DEPEND="exif? ( >=media-libs/libexif-0.6.10 )
	media-libs/tiff
	~media-tv/mythtv-${PV}"

MTVCONF="$(use_enable exif) $(use_enable exif new-exif)"
