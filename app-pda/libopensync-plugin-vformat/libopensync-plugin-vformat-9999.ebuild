# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-vformat/libopensync-plugin-vformat-9999.ebuild,v 1.3 2011/02/24 06:02:14 dirtyepic Exp $

EAPI="3"

inherit cmake-utils subversion

DESCRIPTION="OpenSync VFormat Plugin"
HOMEPAGE="http://www.opensync.org"
SRC_URI=""

ESVN_REPO_URI="http://svn.opensync.org/format-plugins/vformat/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="~app-pda/libopensync-${PV}
	dev-libs/glib:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

# Don't pass
RESTRICT="test"

DOCS="AUTHORS"
