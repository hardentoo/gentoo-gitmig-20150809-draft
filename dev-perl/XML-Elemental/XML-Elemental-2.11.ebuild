# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Elemental/XML-Elemental-2.11.ebuild,v 1.5 2010/05/08 18:12:31 armin76 Exp $

MODULE_AUTHOR=TIMA
inherit perl-module

DESCRIPTION="an XML::Parser style and generic classes for simplistic and perlish handling of XML data. "

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 hppa ia64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/XML-Parser
	dev-perl/XML-SAX
	dev-perl/Class-Accessor
	dev-lang/perl"
RDEPEND="${DEPEND}"
