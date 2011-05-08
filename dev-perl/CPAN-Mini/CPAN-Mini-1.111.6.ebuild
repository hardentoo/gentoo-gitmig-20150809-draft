# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CPAN-Mini/CPAN-Mini-1.111.6.ebuild,v 1.2 2011/05/08 12:29:12 tove Exp $

EAPI=4

MODULE_AUTHOR=RJBS
MODULE_VERSION=1.111006
inherit perl-module

DESCRIPTION="create a minimal mirror of CPAN"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~sparc ~x86"
IUSE="test"

RDEPEND="dev-perl/libwww-perl
	>=virtual/perl-IO-Compress-1.20
	dev-perl/File-HomeDir
	>=virtual/perl-File-Path-2.08
	dev-perl/URI"
DEPEND="${RDEPEND}
	test? ( >=virtual/perl-Test-Simple-0.96 )"

src_test() {
	mv "${S}"/t/app.t{,.disable} || die
	perl-module_src_test
}

SRC_TEST="do"
