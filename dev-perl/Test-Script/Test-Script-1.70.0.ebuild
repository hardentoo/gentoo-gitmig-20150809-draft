# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Script/Test-Script-1.70.0.ebuild,v 1.3 2012/02/29 21:12:44 maekke Exp $

EAPI=4

MODULE_AUTHOR=ADAMK
MODULE_VERSION=1.07
inherit perl-module

DESCRIPTION="Cross-platform basic tests for scripts"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ~ppc ~ppc64 ~s390 ~sh sparc x86 ~x86-fbsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND="virtual/perl-File-Spec
	dev-perl/Probe-Perl
	dev-perl/IPC-Run3
	virtual/perl-Test-Simple"
DEPEND="${RDEPEND}"

SRC_TEST=do
