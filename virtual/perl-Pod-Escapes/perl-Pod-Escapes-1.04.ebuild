# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Pod-Escapes/perl-Pod-Escapes-1.04.ebuild,v 1.4 2009/12/15 20:00:08 abcd Exp $

DESCRIPTION="for resolving Pod E<...> sequences"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~x86-macos"

IUSE=""
DEPEND=""

RDEPEND="|| ( ~dev-lang/perl-5.10.1 ~perl-core/Pod-Escapes-${PV} )"
