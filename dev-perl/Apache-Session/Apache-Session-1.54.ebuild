# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-Session/Apache-Session-1.54.ebuild,v 1.9 2005/05/24 15:42:05 mcummings Exp $

inherit perl-module

IUSE=""

DESCRIPTION="Perl module for Apache::Session"
SRC_URI="mirror://cpan/authors/id/J/JB/JBAKER/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/JBAKER/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"

DEPEND="${DEPEND}
	perl-core/Digest-MD5
	dev-perl/Storable"
