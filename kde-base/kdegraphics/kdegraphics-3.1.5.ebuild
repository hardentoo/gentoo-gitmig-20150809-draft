# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics/kdegraphics-3.1.5.ebuild,v 1.9 2005/01/09 11:08:50 swegener Exp $
inherit kde-dist

IUSE="gphoto2 tetex scanner"
DESCRIPTION="KDE graphics-related apps"

KEYWORDS="x86 ppc sparc hppa amd64 alpha ia64"

DEPEND="gphoto2? ( >=media-gfx/gphoto2-2.0_beta1 )
	scanner? ( media-gfx/sane-backends )
	tetex? ( virtual/tetex )
	media-libs/imlib
	virtual/ghostscript
	virtual/glut virtual/opengl
	media-libs/tiff
	!media-gfx/kpovmodeler
	x86? ( scanner? ( sys-libs/libieee1284 ) )"

RDEPEND="$DEPEND app-text/xpdf"

use gphoto2	&& myconf="$myconf --with-kamera \
			   --with-gphoto2-includes=/usr/include/gphoto2 \
			   --with-gphoto2-libraries=/usr/lib/gphoto2" || \
		myconf="$myconf --without-kamera"

use tetex 	&& myconf="$myconf --with-system-kpathsea --with-tex-datadir=/usr/share"

use scanner	|| KDE_REMOVE_DIR="kooka libkscan"

myconf="$myconf --with-imlib --with-imlib-config=/usr/bin"

