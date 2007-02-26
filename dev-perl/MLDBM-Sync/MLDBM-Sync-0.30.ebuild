# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MLDBM-Sync/MLDBM-Sync-0.30.ebuild,v 1.4 2007/02/26 14:27:08 mcummings Exp $

inherit perl-module

DESCRIPTION="A multidimensional/tied hash Perl Module"
SRC_URI="mirror://cpan/authors/id/C/CH/CHAMAS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~chamas/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="test"
SRC_TEST="do"

DEPEND="dev-lang/perl
		dev-perl/MLDBM
		test? ( virtual/perl-Test-Harness )"
RDEPEND="${DEPEND}"
