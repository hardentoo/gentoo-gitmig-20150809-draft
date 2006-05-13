# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXScrnSaver/libXScrnSaver-1.1.0.ebuild,v 1.2 2006/05/13 08:56:38 spyderous Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org XScrnSaver library"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
RDEPEND="x11-libs/libX11
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	>=x11-proto/scrnsaverproto-1.1"
