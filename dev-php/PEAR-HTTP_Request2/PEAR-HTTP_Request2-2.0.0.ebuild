# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTTP_Request2/PEAR-HTTP_Request2-2.0.0.ebuild,v 1.4 2012/02/08 21:28:29 maekke Exp $

EAPI=4

inherit php-pear-r1

DESCRIPTION="Provides an easy way to perform HTTP requests"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86"
IUSE="+curl +fileinfo +ssl +zlib"

RDEPEND="dev-lang/php[curl?,fileinfo?,ssl?,zlib?]
>=dev-php/PEAR-Net_URL2-0.3.0"
