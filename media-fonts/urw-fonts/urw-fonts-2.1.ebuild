# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/urw-fonts/urw-fonts-2.1.ebuild,v 1.3 2004/05/25 15:06:59 usata Exp $

inherit eutils rpm

DESCRIPTION="free good quality fonts gpl'd by URW++"
HOMEPAGE=""
SRC_URI="ftp://rpmfind.net/linux/fedora/core/development/SRPMS/${P}-7.src.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

#DEPEND="app-arch/rpm2targz"
#DEPEND comes from rpm.eclass

S=${WORKDIR}
FONTPATH="/usr/share/fonts/${PN}"

src_install() {
	insinto ${FONTPATH}
	doins *.afm *.pfb fonts.*
	if [ -x /usr/bin/fc-cache ] ; then
		/usr/bin/fc-cache -f ${D}${FONTPATH}
	fi
	dodoc ChangeLog README* TODO
}
