# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-DateParse/DateTime-Format-DateParse-0.05.ebuild,v 1.3 2011/01/07 20:02:24 xarthisius Exp $

EAPI=2

MODULE_AUTHOR=JHOBLITT
inherit perl-module

DESCRIPTION="Parses Date::Parse compatible formats"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 ~x86"
IUSE=""

RDEPEND=">=dev-perl/DateTime-0.29
	dev-perl/DateTime-TimeZone
	dev-perl/TimeDate"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
