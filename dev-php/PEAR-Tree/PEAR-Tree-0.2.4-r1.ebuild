# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Tree/PEAR-Tree-0.2.4-r1.ebuild,v 1.12 2006/01/28 16:18:57 jer Exp $

inherit php-pear-r1

DESCRIPTION="Generic tree management, currently supports DB and XML as data
sources."
LICENSE="PHP"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc ppc64 sparc x86"
IUSE=""
RDEPEND=">=dev-php/PEAR-DB-1.7.6-r1
	>=dev-php/PEAR-XML_Parser-1.2.7"
