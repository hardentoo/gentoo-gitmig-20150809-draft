# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-webkit/qt-webkit-4.8.0.ebuild,v 1.1 2012/01/29 17:10:32 wired Exp $

EAPI="3"
inherit qt4-build

DESCRIPTION="The Webkit module for the Qt toolkit"
SLOT="4"
KEYWORDS="~amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 -sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="dbus +jit kde"

DEPEND="
	dev-db/sqlite:3
	~x11-libs/qt-core-${PV}[aqua=,c++0x=,qpa=,debug=,ssl]
	~x11-libs/qt-gui-${PV}[aqua=,c++0x=,qpa=,dbus?,debug=]
	~x11-libs/qt-xmlpatterns-${PV}[aqua=,c++0x=,qpa=,debug=]
	dbus? ( ~x11-libs/qt-dbus-${PV}[aqua=,c++0x=,qpa=,debug=] )
	!kde? ( || ( ~x11-libs/qt-phonon-${PV}:${SLOT}[aqua=,c++0x=,qpa=,dbus=,debug=]
		media-libs/phonon[aqua=] ) )
	kde? ( || ( media-libs/phonon[aqua=] ~x11-libs/qt-phonon-${PV}:${SLOT}[aqua=,dbus=,debug=] ) )"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-c++0x-fix.patch" )

pkg_setup() {
	QT4_TARGET_DIRECTORIES="
		src/3rdparty/webkit/Source/JavaScriptCore/
		src/3rdparty/webkit/Source/WebCore/
		src/3rdparty/webkit/Source/WebKit/qt/
		tools/designer/src/plugins/qwebview"

	QT4_EXTRACT_DIRECTORIES="
		include/
		src/
		tools/"

	QCONFIG_ADD="webkit"
	QCONFIG_DEFINE="QT_WEBKIT"

	qt4-build_pkg_setup
}

src_prepare() {
	[[ $(tc-arch) == "ppc64" ]] && append-flags -mminimal-toc #241900
	use c++0x && append-flags -fpermissive
	sed -i -e "/Werror/d" "${S}/src/3rdparty/webkit/Source/WebKit.pri" || die
	qt4-build_src_prepare
}

src_configure() {
	# won't build with gcc 4.6 without this for now
	myconf="${myconf}
			-webkit -system-sqlite -no-gtkstyle
			-D GST_DISABLE_DEPRECATED
			$(qt_use jit javascript-jit)
			$(qt_use dbus qdbus)"
	qt4-build_src_configure
}
