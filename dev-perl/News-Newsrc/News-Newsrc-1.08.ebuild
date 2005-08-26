# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/News-Newsrc/News-Newsrc-1.08.ebuild,v 1.8 2005/08/26 02:26:00 agriffis Exp $

inherit perl-module

DESCRIPTION="Manage newsrc files"
SRC_URI="mirror://cpan/authors/id/S/SW/SWMCD/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-module/News/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha ~amd64 ~hppa ~ia64 ~ppc sparc x86"
SRC_TEST="do"
DEPEND=">=dev-perl/Set-IntSpan-1.07"

