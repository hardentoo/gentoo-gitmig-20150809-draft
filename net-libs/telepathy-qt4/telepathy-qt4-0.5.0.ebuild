# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/telepathy-qt4/telepathy-qt4-0.5.0.ebuild,v 1.1 2010/11/18 14:57:43 chiiph Exp $

PYTHON_DEPEND="2"

EAPI="2"
inherit python base cmake-utils

DESCRIPTION="Qt4 bindings for the Telepathy D-Bus protocol"
HOMEPAGE="http://telepathy.freedesktop.org/"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="x11-libs/qt-core:4
	x11-libs/qt-dbus:4"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	dev-util/pkgconfig
	net-libs/telepathy-farsight"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_configure() {
	mycmakeargs="-DHAVE_QDBUSVARIANT_OPERATOR_EQUAL=1 "
	if use debug; then
		mycmakeargs+="-DCMAKE_BUILD_TYPE=Debug"
	fi
	cmake-utils_src_configure
}
