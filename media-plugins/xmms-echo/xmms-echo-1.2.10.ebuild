# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-echo/xmms-echo-1.2.10.ebuild,v 1.4 2005/05/09 04:45:54 agriffis Exp $

IUSE=""
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ia64 ~mips ~ppc ~ppc64 sparc x86"

DEPEND=">=media-sound/xmms-1.2.10"

PLUGIN_PATH="Effect/echo_plugin"

M4_VER="1.1"

inherit xmms-plugin
