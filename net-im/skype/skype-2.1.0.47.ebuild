# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/skype/skype-2.1.0.47.ebuild,v 1.3 2010/01/02 12:24:15 ssuominen Exp $

EAPI=2

inherit eutils qt4 pax-utils

DESCRIPTION="A P2P-VoiceIP client."
HOMEPAGE="http://www.skype.com/"

SFILENAME=${PN}_static-${PV}.tar.bz2
DFILENAME=${P}.tar.bz2
SRC_URI="!qt-static? ( http://download.skype.com/linux/${DFILENAME} )
	qt-static? ( http://download.skype.com/linux/${SFILENAME} )"

LICENSE="skype-eula"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt-static"
RESTRICT="mirror"

EMUL_VER=20091231

RDEPEND="amd64? ( >=app-emulation/emul-linux-x86-xlibs-${EMUL_VER}
			>=app-emulation/emul-linux-x86-baselibs-${EMUL_VER}
			>=app-emulation/emul-linux-x86-soundlibs-${EMUL_VER}
			!qt-static? ( >=app-emulation/emul-linux-x86-qtlibs-${EMUL_VER} ) )
	x86? ( >=sys-libs/glibc-2.4
		>=media-libs/alsa-lib-1.0.11
		x11-libs/libXScrnSaver
		x11-libs/libXv
		qt-static? ( media-libs/fontconfig
			media-libs/freetype
			x11-libs/libICE
			x11-libs/libSM
			x11-libs/libXcursor
			x11-libs/libXext
			x11-libs/libXfixes
			x11-libs/libXi
			x11-libs/libXinerama
			x11-libs/libXrandr
			x11-libs/libXrender
			x11-libs/libX11 )
		!qt-static? ( x11-libs/qt-gui:4[accessibility,dbus]
			x11-libs/qt-dbus:4
			x11-libs/libX11
			x11-libs/libXau
			x11-libs/libXdmcp ) )"
# Required for lrelease command.
DEPEND="${RDEPEND}
	amd64? ( !qt-static? ( x11-libs/qt-core:4 ) )"

QA_EXECSTACK="opt/skype/skype"
QA_WX_LOAD="opt/skype/skype"
QA_DT_HASH="opt/skype/skype"
QA_PRESTRIPPED="opt/skype/skype"

use qt-static && S="${WORKDIR}/${PN}_static-${PV}"

src_install() {
	# remove mprotect() restrictions for PaX usage - see Bug 100507
	# NOTE. Commented out because it's breaking Skype 2.1.0.47.
	# pax-mark m "${S}"/skype

	exeinto /opt/${PN}
	doexe skype || die
	fowners root:audio /opt/skype/skype
	make_wrapper skype /opt/${PN}/skype /opt/${PN} /opt/${PN} /usr/bin

	insinto /opt/${PN}/sounds
	doins sounds/*.wav || die

	if ! use qt-static ; then
		insinto /etc/dbus-1/system.d
		doins ${PN}.conf || die
	fi

	insinto /opt/${PN}/lang
	#
	#There have been some issues were lang is not updated from the .ts files
	#but if we have qt we can rebuild it
	#
	if ! use qt-static ; then
		lrelease lang/*.ts
	fi

	doins lang/*.qm || die

	insinto /opt/${PN}/avatars
	doins avatars/*.png || die

	insinto /opt/${PN}
	for X in 16 32 48
	do
		insinto /usr/share/icons/hicolor/${X}x${X}/apps
		newins "${S}"/icons/SkypeBlue_${X}x${X}.png ${PN}.png
	done

	dodoc README

	# insinto /usr/share/applications/
	# doins skype.desktop
	make_desktop_entry ${PN} "Skype VoIP" ${PN} "Network;InstantMessaging;Telephony"

	#Fix for no sound notifications
	dosym /opt/${PN} /usr/share/${PN}

	# TODO: Optional configuration of callto:// in KDE, Mozilla and friends
	# doexe skype-callto-handler
}
