# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ExtUtils-AutoInstall/ExtUtils-AutoInstall-0.59.ebuild,v 1.1 2004/06/05 19:00:59 mcummings Exp $

IUSE=""

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Allows module writers to specify a more sophisticated form of dependency information"
SRC_URI="http://search.cpan.org/CPAN/authors/id/A/AU/AUTRIJUS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/AUTRIJUS/${P}/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"

DEPEND="dev-perl/Sort-Versions"


src_compile() {
	echo "n" | perl-module_src_compile
}
