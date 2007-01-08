# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-DT/XML-DT-0.47.ebuild,v 1.3 2007/01/08 17:06:03 mcummings Exp $

inherit perl-module

DESCRIPTION="A perl XML down translate module"
SRC_URI="mirror://cpan/authors/id/A/AM/AMBS/XML/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~ambs/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="amd64 ~hppa ~ia64 ~ppc sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/libwww-perl-1.35
	>=dev-perl/XML-LibXML-1.54
	>=dev-perl/XML-DTDParser-2.00
	virtual/perl-Test-Simple
	dev-perl/Test-Pod
	dev-perl/Test-Pod-Coverage
	dev-lang/perl"

src_compile() {
	echo "" | perl-module_src_compile
}

