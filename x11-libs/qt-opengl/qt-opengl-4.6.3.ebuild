# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-opengl/qt-opengl-4.6.3.ebuild,v 1.9 2011/08/17 16:56:33 chithanh Exp $

EAPI="2"
inherit qt4-build

DESCRIPTION="The OpenGL module for the Qt toolkit"
SLOT="4"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="qt3support"

DEPEND="~x11-libs/qt-core-${PV}[aqua=,debug=,qt3support=]
	~x11-libs/qt-gui-${PV}[aqua=,debug=,qt3support=]
	virtual/opengl"
RDEPEND="${DEPEND}"

QT4_TARGET_DIRECTORIES="
src/opengl
src/plugins/graphicssystems/opengl"

QT4_EXTRACT_DIRECTORIES="
include/QtCore
include/QtGui
include/QtOpenGL
src/corelib
src/gui
src/opengl
src/plugins
src/3rdparty"

QCONFIG_ADD="opengl"
QCONFIG_DEFINE="QT_OPENGL"

src_configure() {
	myconf="${myconf} -opengl
		$(qt_use qt3support)"

	qt4-build_src_configure

	# Not building tools/designer/src/plugins/tools/view3d as it's
	# commented out of the build in the source
}
