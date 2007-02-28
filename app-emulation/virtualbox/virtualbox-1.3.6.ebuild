# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

inherit eutils qt3

MY_P=VirtualBox-OSE-${PV}
DESCRIPTION="Softwarefamily of powerful x86 virtualization"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="http://www.virtualbox.org/download/${PV}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 ~x86"
IUSE="additions alsa sdk vboxbfe vditool wrapper"

RDEPEND="!app-emulation/virtualbox-bin
	=app-emulation/virtualbox-modules-${PV}
	dev-libs/libIDL
	>=dev-libs/libxslt-1.1.19
	dev-libs/xalan-c
	dev-libs/xerces-c
	media-libs/libsdl
	x11-libs/libXcursor
	$(qt_min_version 3.3.5)
	=virtual/libstdc++-3.3"
DEPEND="${RDEPEND}
	sys-devel/bin86
	sys-devel/dev86
	sys-power/iasl
	alsa? ( >=media-libs/alsa-lib-1.0.13 )"
RDEPEND="${RDEPEND}
	additions? ( =app-emulation/virtualbox-additions-${PV} )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Remove Alsa checks in configure and don't build the Alsa audio driver, when Alsa is not selected
	use alsa || epatch "${FILESDIR}/${P}-remove-alsa.patch"
}

src_compile() {
	cd "${S}"
	./configure || die "configure failed"
	source ./env.sh
	kmk all || die "kmk failed"
}

src_install() {
	cd "${S}"/out/linux.${ARCH}/release/bin

	insinto /opt/VirtualBox
	if use sdk; then
		doins -r sdk
		make_wrapper xpidl "sdk/bin/xpidl" "/opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"
		fperms 0755 /opt/VirtualBox/sdk/bin/xpidl
	fi
	if use vditool; then
		doins vditool
		make_wrapper vditool "./vditool" "/opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"
		fperms 0755 /opt/VirtualBox/vditool
	fi
	if use vboxbfe; then
		doins VBoxBFE
		fperms 0755 /opt/VirtualBox/VBoxBFE

		if use wrapper ; then
			dosym /opt/VirtualBox/wrapper.sh /usr/bin/VBoxBFE
		else
			make_wrapper vboxbfe "./VBoxBFE" "/opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"
		fi
	fi

	rm -rf sdk src tst* testcase additions VBoxBFE vditool vboxdrv.ko xpidl SUPInstall SUPUninstall

	doins -r *
	for each in VBox{Manage,SDL,SVC,XPCOMIPCD} VirtualBox ; do
		fperms 0755 /opt/VirtualBox/${each}
	done

	if use wrapper ; then
		exeinto /opt/VirtualBox
		newexe "${FILESDIR}/${P}-wrapper" "wrapper.sh"
		dosym /opt/VirtualBox/wrapper.sh /usr/bin/VirtualBox
		dosym /opt/VirtualBox/wrapper.sh /usr/bin/VBoxManage
		dosym /opt/VirtualBox/wrapper.sh /usr/bin/VBoxSDL
	else
		make_wrapper vboxsvc "./VBoxSVC" "/opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"
		make_wrapper virtualbox "./VirtualBox" "/opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"
		make_wrapper vboxmanage "./VBoxManage" "/opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"
		make_wrapper vboxsdl "./VBoxSDL" "/opt/VirtualBox" "/opt/VirtualBox" "/usr/bin"
	fi

	# desktop entry
	insinto /usr/share/pixmaps
	newins "${S}"/src/VBox/Frontends/VirtualBox/images/ico32x01.png ${PN}.png
	insinto /usr/share/applications
	doins "${FILESDIR}"/${PN}.desktop
}

pkg_postinst() {
	elog ""
	elog "In order to launch VirtualBox you need to start VBoxSVC first, with:"
	elog "vboxsvc --daemonize && virtualbox"
	elog ""
	elog "If you selected the useflag \"wrapper\" just type \"VirtualBox\" instead."
	elog ""
	elog "You must be in the vboxusers group to use VirtualBox."
	elog ""
	elog "The last user manual is available for download at:"
	elog "http://www.virtualbox.org/download/UserManual.pdf"
	elog ""
}
