# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/edje/edje-0.0.1.20040221.ebuild,v 1.2 2004/02/23 01:43:41 vapier Exp $

inherit enlightenment

DESCRIPTION="graphical layout and animation library"
HOMEPAGE="http://www.enlightenment.org/pages/edje.html"

DEPEND=">=dev-libs/eet-0.9.0.20040117
	>=x11-libs/evas-1.0.0.20031020_pre11
	>=media-libs/imlib2-1.1.0
	>=x11-libs/ecore-1.0.0.20031018_pre4"

src_compile() {
	export MAKEOPTS="${MAKEOPTS} -j1"
	enlightenment_src_compile
}
