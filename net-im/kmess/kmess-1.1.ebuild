# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kmess/kmess-1.1.ebuild,v 1.1 2003/03/16 16:09:18 hannes Exp $

inherit kde-base

S="${WORKDIR}/${P}"
need-kde 3

DESCRIPTION="MSN Messenger clone for KDE"
SRC_URI="mirror://sourceforge/kmess/${P}.tar.gz"
HOMEPAGE="http://kmess.sourceforge.net"


LICENSE="GPL-2"
KEYWORDS="~x86"
