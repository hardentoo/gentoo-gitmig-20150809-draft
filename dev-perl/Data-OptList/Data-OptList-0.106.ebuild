# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-OptList/Data-OptList-0.106.ebuild,v 1.3 2010/06/27 16:24:09 nixnut Exp $

EAPI=2

MODULE_AUTHOR=RJBS
inherit perl-module

DESCRIPTION="parse and validate simple name/value option pairs"

SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="test"

RDEPEND="dev-perl/Sub-Install
	dev-perl/Params-Util"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
