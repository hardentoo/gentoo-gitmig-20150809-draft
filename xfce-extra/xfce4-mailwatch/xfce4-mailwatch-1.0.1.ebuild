# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-mailwatch/xfce4-mailwatch-1.0.1.ebuild,v 1.4 2007/02/02 18:14:42 gustavoz Exp $

inherit xfce44

xfce44_beta
xfce44_panel_plugin

DESCRIPTION="Xfce4 mail notification panel plugin"
HOMEPAGE="http://spuriousinterrupt.org/projects/mailwatch"
SRC_URI="http://spuriousinterrupt.org/files/mailwatch/${MY_P}.tar.bz2"
KEYWORDS="~amd64 ~ppc64 ~sparc ~x86"

IUSE="ssl"

DEPEND=">=dev-util/intltool-0.31
	x11-libs/libX11
	x11-libs/libSM
	>=x11-libs/gtk+-2.4
	>=xfce-base/libxfce4util-4.2
	>=xfce-base/libxfcegui4-4.2
	ssl? ( >=net-libs/gnutls-1.2 )"

XFCE_CONFIG="$(use_enable ssl)"
