# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/xdg-menu/xdg-menu-1.0.ebuild,v 1.2 2005/11/19 18:36:02 svyatogor Exp $

MY_PN="XDG-Menu"
DESCRIPTION="XDG-Menu is a ROX Menu Application that is XDG Compliant."
HOMEPAGE="http://xdg-menu.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
DEPEND=">=dev-python/pyxdg-0.14"
IUSE=""

ROX_LIB_VER=2.0.0
APPNAME=${MY_PN}
S=${WORKDIR}

inherit rox
