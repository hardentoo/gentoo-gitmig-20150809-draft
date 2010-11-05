# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-HomeDir/File-HomeDir-0.93.ebuild,v 1.3 2010/11/05 13:12:45 hwoarang Exp $

EAPI=3

MODULE_AUTHOR=ADAMK
inherit perl-module

DESCRIPTION="Get home directory for self or other user"

SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd ~x86-solaris"
IUSE=""

RDEPEND="virtual/perl-File-Spec
	>=virtual/perl-File-Temp-0.19
	dev-perl/File-Which"
DEPEND="${RDEPEND}"

SRC_TEST="do"
