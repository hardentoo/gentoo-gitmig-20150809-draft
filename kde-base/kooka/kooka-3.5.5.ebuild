# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kooka/kooka-3.5.5.ebuild,v 1.1 2006/10/03 11:38:31 flameeyes Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Kooka is a KDE application which provides access to scanner hardware"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkscan)
	media-libs/tiff"
RDEPEND="${DEPEND}"

KMCOPYLIB="libkscan libkscan"
KMEXTRACTONLY="libkscan"

src_compile() {
	# There's no ebuild for kadmos, and likely will never be since it isn't free.
	myconf="$myconf --without-kadmos"
	kde-meta_src_compile
}
