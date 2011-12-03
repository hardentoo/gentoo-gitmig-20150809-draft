# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vmware-player/vmware-player-4.0.1.528992-r1.ebuild,v 1.1 2011/12/03 20:07:45 vadimk Exp $

EAPI="4"

inherit eutils versionator fdo-mime gnome2-utils vmware-bundle

MY_PN="VMware-Player"
MY_PV="$(replace_version_separator 3 - $PV)"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Emulate a complete PC on your PC without the usual performance overhead of most emulators"
HOMEPAGE="http://www.vmware.com/products/player/"
SRC_URI="
	x86? ( ${MY_P}.i386.bundle )
	amd64? ( ${MY_P}.x86_64.bundle )
	"

LICENSE="vmware"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="cups doc +vmware-tools"
RESTRICT="binchecks fetch strip"

# vmware-workstation should not use virtual/libc as this is a
# precompiled binary package thats linked to glibc.
RDEPEND="dev-cpp/cairomm
	dev-cpp/glibmm:2
	dev-cpp/gtkmm:2.4
	dev-cpp/libgnomecanvasmm:2.6
	dev-cpp/libsexymm
	dev-cpp/pangomm:1.4
	dev-libs/atk
	dev-libs/glib:2
	dev-libs/libaio
	dev-libs/libsigc++
	dev-libs/libxml2
	=dev-libs/openssl-0.9.8*
	dev-libs/xmlrpc-c
	gnome-base/libgnomecanvas
	gnome-base/libgtop:2
	gnome-base/librsvg:2
	gnome-base/orbit
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libart_lgpl
	=media-libs/libpng-1.2*
	net-misc/curl
	cups? ( net-print/cups )
	sys-devel/gcc
	sys-fs/fuse
	sys-libs/glibc
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gtk+:2
	x11-libs/libgksu
	x11-libs/libICE
	x11-libs/libsexy
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXft
	x11-libs/libXi
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/pango
	x11-libs/startup-notification
	!app-emulation/vmware-workstation"
PDEPEND="~app-emulation/vmware-modules-264.1
	vmware-tools? ( app-emulation/vmware-tools )"

S=${WORKDIR}
VM_INSTALL_DIR="/opt/vmware"

pkg_nofetch() {
	local bundle

	if use x86; then
		bundle="${MY_P}.i386.bundle"
	elif use amd64; then
		bundle="${MY_P}.x86_64.bundle"
	fi

	einfo "Please download ${bundle}"
	einfo "from ${HOMEPAGE}"
	einfo "and place it in ${DISTDIR}"
}

src_unpack() {
	local component ; for component in \
			vmware-player \
			vmware-player-app \
			vmware-vmx \
			vmware-usbarbitrator \
			vmware-network-editor \
			vmware-player-setup
			#vmware-ovftool
	do
		vmware-bundle_extract-bundle-component "${DISTDIR}/${A}" "${component}" "${S}"
	done
}

src_prepare() {
	rm -f bin/vmware-modconfig
	rm -rf lib/modules/binary
}

clean_bundled_libs() {
	ebegin 'Removing superfluous libraries'
	# exclude OpenSSL from unbundling until the AES-NI patch gets into the tree
	# see http://forums.gentoo.org/viewtopic-t-835867.html
	# must use shipped libgcr.so.0 or else "undefined symbol: gcr_certificate_widget_new"
	ldconfig -p | sed 's:^\s\+\([^(]*[^( ]\).*=> \(/.*\)$:\1 \2:g;t;d' | fgrep -v 'libcrypto.so.0.9.8
libssl.so.0.9.8
libgcr.so.0' | while read -r libname libpath ; do
		dosym "${libpath}" "${VM_INSTALL_DIR}/lib/vmware/lib/${libname}/${libname}"
	done
	eend
}

src_install() {
	local major_minor_revision=$(get_version_component_range 1-3 "${PV}")
	local build=$(get_version_component_range 4 "${PV}")

	# install the binaries
	into "${VM_INSTALL_DIR}"
	dobin bin/* || die "failed to install bin"

	# install the libraries
	insinto "${VM_INSTALL_DIR}"/lib/vmware
	doins -r lib/*

	# install the ancillaries
	insinto /usr
	doins -r share

	if use cups; then
		exeinto $(cups-config --serverbin)/filter
		doexe extras/thnucups

		insinto /etc/cups
		doins -r etc/cups/*
	fi

	# install documentation
	if use doc; then
		dodoc doc/*
	fi

	exeinto "${VM_INSTALL_DIR}"/lib/vmware/setup
	doexe vmware-config

	# create symlinks for the various tools
	local tool ; for tool in thnuclnt vmplayer{,-daemon} \
			vmware-{acetool,unity-helper,modconfig{,-console},gksu,fuseUI} ; do
		dosym appLoader "${VM_INSTALL_DIR}"/lib/vmware/bin/"${tool}"
	done
	dosym "${VM_INSTALL_DIR}"/lib/vmware/bin/vmplayer "${VM_INSTALL_DIR}"/bin/vmplayer
	dosym "${VM_INSTALL_DIR}"/lib/vmware/icu /etc/vmware/icu

	# fix up permissions
	fperms 0755 "${VM_INSTALL_DIR}"/lib/vmware/{bin/*,lib/wrapper-gtk24.sh,lib/libgksu2.so.0/gksu-run-helper}
	fperms 4711 "${VM_INSTALL_DIR}"/lib/vmware/bin/vmware-vmx*

	# create the environment
	local envd="${T}/90vmware"
	cat > "${envd}" <<-EOF
		PATH='${VM_INSTALL_DIR}/bin'
		ROOTPATH='${VM_INSTALL_DIR}/bin'
	EOF
	doenvd "${envd}" || die

	# create the configuration
	dodir /etc/vmware || die

	cat > "${D}"/etc/vmware/bootstrap <<-EOF
		BINDIR='${VM_INSTALL_DIR}/bin'
		LIBDIR='${VM_INSTALL_DIR}/lib'
	EOF

	cat > "${D}"/etc/vmware/config <<-EOF
		bindir = "${VM_INSTALL_DIR}/bin"
		libdir = "${VM_INSTALL_DIR}/lib/vmware"
		initscriptdir = "/etc/init.d"
		authd.fullpath = "${VM_INSTALL_DIR}/sbin/vmware-authd"
		gksu.rootMethod = "su"
		VMCI_CONFED = "yes"
		VMBLOCK_CONFED = "yes"
		VSOCK_CONFED = "yes"
		NETWORKING = "yes"
		player.product.version = "${major_minor_revision}"
		product.buildNumber = "${build}"
	EOF

	# install the init.d script
	local initscript="${T}/vmware.rc"

	sed -e "s:@@BINDIR@@:${VM_INSTALL_DIR}/bin:g" \
		"${FILESDIR}/vmware-3.0.rc" > "${initscript}" || die
	newinitd "${initscript}" vmware || die

	# fill in variable placeholders
	sed -e "s:@@LIBCONF_DIR@@:${VM_INSTALL_DIR}/lib/vmware/libconf:g" \
		-i "${D}${VM_INSTALL_DIR}"/lib/vmware/libconf/etc/{gtk-2.0/{gdk-pixbuf.loaders,gtk.immodules},pango/pango{.modules,rc}} || die
	sed -e "s:@@BINARY@@:${VM_INSTALL_DIR}/bin/vmplayer:g" \
		-i "${D}/usr/share/applications/${PN}.desktop" || die
}

pkg_config() {
	"${VM_INSTALL_DIR}"/bin/vmware-networks --postinstall ${PN},old,new
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update

	ewarn "/etc/env.d was updated. Please run:"
	ewarn "env-update && source /etc/profile"
	ewarn ""
	ewarn "Before you can use vmware-player, you must configure a default network setup."
	ewarn "You can do this by running 'emerge --config ${PN}'."
}

pkg_prerm() {
	einfo "Stopping ${PN} for safe unmerge"
	/etc/init.d/vmware stop
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
