# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/aqbanking/aqbanking-1.6.0_beta.ebuild,v 1.1 2005/09/26 16:12:11 hanno Exp $

inherit kde-functions

DESCRIPTION="Generic Online Banking Interface"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="mirror://sourceforge/aqbanking/${P/_/}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ia64 ~ppc ~sparc ~alpha ~amd64"
IUSE="debug ofx geldkarte chipcard dtaus hbci kde gtk2 qt python"
DEPEND=">=sys-libs/gwenhywfar-1.16.0
	app-misc/ktoblzcheck
	ofx? >=dev-libs/libofx-0.8
	geldkarte? >=sys-libs/libchipcard-1.9.15_beta
	chipcard? >=sys-libs/libchipcard-1.9.15_beta
	gtk2? >=dev-util/glade-2"

# ctypes is not yet keyworded on most archs
#	python? dev-python/ctypes
S=${WORKDIR}/${P/_/}


use qt && need-qt 3.1
use kde && need-kde 3.1

src_compile() {
	local FRONTENDS="cbanking"
	use qt && FRONTENDS="${FRONTENDS} qbanking"
	use kde && FRONTENDS="${FRONTENDS} kbanking"
	use gtk2 && FRONTENDS="${FRONTENDS} g2banking"

	local BACKENDS=""
	use hbci && BACKENDS="aqhbci"
	use geldkarte && BACKENDS="${BACKENDS} aqgeldkarte"
	use ofx && BACKENDS="${BACKENDS} aqofxconnect"
	use dtaus && BACKENDS="${BACKENDS} aqdtaus"

	econf $(use_enable debug) \
		$(use_enable kde kde3) \
		--with-frontends="${FRONTENDS}" \
		--with-backends="${BACKENDS}" || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS README COPYING doc/*
}
