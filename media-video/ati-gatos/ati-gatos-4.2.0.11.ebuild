# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/ati-gatos/ati-gatos-4.2.0.11.ebuild,v 1.3 2002/07/11 06:30:42 drobbins Exp $

S=${WORKDIR}/X11R6
MY_P=ATI-4.2.0-11
DESCRIPTION="ATI drivers for Xfree86 that support ATI video capabilities"
SRC_URI="mirror://sourceforge/gatos/${MY_P}.i386.tar.gz"
HOMEPAGE="http://gatos.sourceforge.net"

DEPEND="x11-base/xfree"

src_install () {
	dodoc ${S}/README* ${S}/ATI*
	cd ${S}/lib/modules
	insinto /usr/X11R6/lib/modules/multimedia
	doins multimedia/*
	insinto /usr/X11R6/lib/modules/drivers
	doins drivers/*
}
