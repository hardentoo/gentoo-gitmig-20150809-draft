# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-adobe-utopia-100dpi/font-adobe-utopia-100dpi-1.0.1.ebuild,v 1.6 2006/07/10 16:35:28 agriffis Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular


DESCRIPTION="X.Org Adobe Utopia bitmap fonts"
KEYWORDS="~amd64 ~arm ~hppa ia64 ~ppc ppc64 ~s390 ~sparc ~x86"
RDEPEND=""
DEPEND="${RDEPEND}
	x11-apps/bdftopcf
	media-fonts/font-util"

CONFIGURE_OPTIONS="--with-mapfiles=${XDIR}/share/fonts/util"
