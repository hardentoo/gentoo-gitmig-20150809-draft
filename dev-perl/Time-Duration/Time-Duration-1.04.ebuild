# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Time-Duration/Time-Duration-1.04.ebuild,v 1.10 2007/05/12 04:57:16 kumba Exp $

inherit perl-module

DESCRIPTION="Rounded or exact English expression of durations"
HOMEPAGE="http://search.cpan.org/~avif/${P}"
SRC_URI="mirror://cpan/authors/id/A/AV/AVIF/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""

DEPEND="dev-lang/perl"
