# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Symdump/Devel-Symdump-2.03.ebuild,v 1.11 2004/12/23 09:22:12 nigoro Exp $

inherit perl-module

CATEGORY="dev-perl"

DESCRIPTION="dump symbol names or the symbol table"
HOMEPAGE="http://search.cpan.org/~andk/${P}"
SRC_URI="mirror://cpan/authors/id/A/AN/ANDK/${P}.tar.gz"

SRC_TEST="do"
LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 ~ppc sparc alpha ~amd64 ~ppc64"
IUSE=""
