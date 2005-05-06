# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-SQLite/DBD-SQLite-1.08.ebuild,v 1.2 2005/05/06 00:53:59 swegener Exp $

inherit perl-module eutils

DESCRIPTION="Self Contained RDBMS in a DBI Driver"
HOMEPAGE="http://search.cpan.org/~msergeant/${P}/"
SRC_URI="mirror://cpan/authors/id/M/MS/MSERGEANT/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE=""
SRC_TEST="do"

DEPEND=">=dev-perl/DBI-1.42
		!<dev-perl/DBD-SQLite-1"
