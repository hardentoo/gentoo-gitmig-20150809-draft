# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/khelpcenter/khelpcenter-4.2.1.ebuild,v 1.3 2009/04/11 05:41:58 jer Exp $

EAPI="2"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="The KDE Help Center"
IUSE="debug"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"

RDEPEND="
	dev-lang/perl
	>=www-misc/htdig-3.2.0_beta6-r1
"

KMEXTRA="
	doc/faq
	doc/glossary
	doc/quickstart
	doc/userguide
	doc/visualdict
"
