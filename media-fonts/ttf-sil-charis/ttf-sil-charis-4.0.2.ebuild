# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/ttf-sil-charis/ttf-sil-charis-4.0.2.ebuild,v 1.8 2006/11/26 23:57:03 flameeyes Exp $

inherit font versionator

DESCRIPTION="Charis Typeface"
HOMEPAGE="http://scripts.sil.org/CharisSILfont"
SRC_URI="mirror://gentoo/${P}.tgz"

LICENSE="OFL"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="X doc"

DOCS="FONTLOG.txt OFL.txt OFL-FAQ.txt README.txt"
FONT_SUFFIX="ttf"

FONT_S="${S}"

src_install() {
	font_src_install
	if use doc ; then
		insinto /usr/share/doc/${PN}-${PVR}
		doins *.pdf
	fi
}
