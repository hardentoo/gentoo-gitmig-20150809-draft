# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-session/xfce4-session-4.1.99.3-r1.ebuild,v 1.1 2005/01/06 21:23:21 bcowan Exp $

DESCRIPTION="Xfce 4 session manager"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

XFCE_RDEPEND="=xfce-base/xfce-utils-${PV}-r1"
SINGLE_MAKE=1

inherit xfce4
