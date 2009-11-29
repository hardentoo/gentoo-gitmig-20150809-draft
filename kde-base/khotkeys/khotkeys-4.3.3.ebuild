# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/khotkeys/khotkeys-4.3.3.ebuild,v 1.3 2009/11/29 17:54:06 armin76 Exp $

EAPI="2"

KMNAME="kdebase-workspace"
inherit kde4-meta

DESCRIPTION="KDE: hotkey daemon"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkworkspace)
	x11-libs/libXtst
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	libs/kworkspace/
"
