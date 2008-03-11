# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdeedu/libkdeedu-4.0.2.ebuild,v 1.1 2008/03/11 00:00:09 philantrop Exp $

EAPI="1"

KMNAME=kdeedu
inherit kde4-meta

# get weird "Exception: Other". broken.
RESTRICT="test"

DESCRIPTION="common library for kde educational apps."
KEYWORDS="~amd64 ~x86"
IUSE="debug"
