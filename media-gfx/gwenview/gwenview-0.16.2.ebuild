# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gwenview/gwenview-0.16.2.ebuild,v 1.3 2003/04/24 11:27:47 vapier Exp $

inherit kde-base
need-kde 3

newdepend ">=kde-base/kdebase-3.0"

DESCRIPTION="image viewer for KDE"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://gwenview.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86"
