# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Deep/Test-Deep-0.095.ebuild,v 1.4 2006/08/06 18:28:10 mcummings Exp $

inherit perl-module
IUSE=""

DESCRIPTION="Extremely flexible deep comparison"
SRC_URI="mirror://cpan/authors/id/F/FD/FDALY/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~fdaly/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="amd64 ~ppc sparc ~x86"

SRC_TEST="do"
DEPEND="dev-perl/Test-NoWarnings
	dev-perl/Test-Tester
	dev-lang/perl"

RDEPEND="${DEPEND}"


