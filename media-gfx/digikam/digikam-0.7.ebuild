# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/digikam/digikam-0.7.ebuild,v 1.4 2005/01/04 22:12:13 carlo Exp $

inherit kde

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="digiKam is a digital photo management application for KDE."
HOMEPAGE="http://digikam.sourceforge.net/"
SRC_URI="mirror://sourceforge/digikam/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND=">=media-gfx/gphoto2-2.0-r1
	media-libs/imlib
	media-libs/imlib2
	media-libs/libkexif
	media-libs/libkipi
	sys-libs/gdbm
	!media-plugins/digikamplugins"
RDEPEND=">=media-gfx/gphoto2-2.0-r1
	media-libs/imlib
	media-libs/imlib2
	media-libs/libkexif
	media-libs/libkipi
	sys-libs/gdbm"
need-kde 3.2
