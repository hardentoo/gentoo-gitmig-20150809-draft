# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-firmware/alsa-firmware-1.0.7.ebuild,v 1.4 2005/01/23 11:24:42 eradicator Exp $

IUSE=""

MY_P=${P/_rc/rc}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Advanced Linux Sound Architecture firmware"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/firmware/${P}.tar.bz2"

SLOT="0"
KEYWORDS="amd64 sparc x86"
LICENSE="GPL-2"

DEPEND=""

src_install () {
	make DESTDIR="${D}" install || die
	dodoc README
}
