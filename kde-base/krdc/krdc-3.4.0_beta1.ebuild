# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/krdc/krdc-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:37 danarmak Exp $

KMNAME=kdenetwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE remote desktp connection (RDP and VNC) cient"
KEYWORDS="~x86"
IUSE="rdesktop slp"
DEPEND=">=dev-libs/openssl-0.9.6b
	slp? ( net-libs/openslp )"
RDEPEND="${DEPEND}
	rdesktop? ( >=net-misc/rdesktop-1.3.1-r1 )"

src_compile() {
	myconf="$myconf `use_enable slp`"
	kde-meta_src_compile
}