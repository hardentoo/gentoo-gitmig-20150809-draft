# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-Preferred/Lingua-Preferred-0.2.1.ebuild,v 1.2 2003/02/12 04:03:59 seemant Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Perl module for Lingua::Preferred"
SRC_URI="http://search.cpan.org/CPAN/authors/id/E/ED/EDAVIS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/EDAVIS/${P}"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="${DEPEND}
	dev-perl/Log-TraceMessages"
