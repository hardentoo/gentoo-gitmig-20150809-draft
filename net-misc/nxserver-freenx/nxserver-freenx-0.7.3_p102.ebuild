# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxserver-freenx/nxserver-freenx-0.7.3_p102.ebuild,v 1.3 2009/03/20 16:39:05 voyageur Exp $

EAPI=1

inherit multilib eutils toolchain-funcs versionator

MAJOR_PV="$(get_version_component_range 1-3)"
PATCH_VER="$(get_version_component_range 4)"
MY_PN="freenx-server"

DESCRIPTION="Free Software Implementation of the NX Server"
HOMEPAGE="http://freenx.berlios.de/ https://launchpad.net/~freenx-team"
SRC_URI="http://ppa.launchpad.net/freenx-team/ppa/ubuntu/pool/main/f/${MY_PN}/freenx-server_${MAJOR_PV}+teambzr${PATCH_VER/p}.orig.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="strip"
IUSE="arts cups esd +nxclient rdesktop vnc"

DEPEND="x11-misc/gccmakedep
	x11-misc/imake"
RDEPEND="dev-tcltk/expect
	media-fonts/font-misc-misc
	media-fonts/font-cursor-misc
	net-analyzer/gnu-netcat
	>=net-misc/nx-2.1.0
	sys-apps/gawk
	virtual/ssh
	x11-apps/xauth
	x11-apps/xrdb
	x11-apps/sessreg
	arts? ( kde-base/arts )
	cups? ( net-print/cups )
	esd? ( media-sound/esound )
	nxclient? ( net-misc/nxclient )
	!nxclient? ( !net-misc/nxclient
				 || ( x11-misc/xdialog
					  x11-apps/xmessage ) )
	rdesktop? ( net-misc/rdesktop )
	vnc? ( x11-misc/x11vnc
		   || ( net-misc/tightvnc net-misc/vnc ) )
	!net-misc/nxserver-freeedition
	!net-misc/nxserver-2xterminalserver"

S=${WORKDIR}/${MY_PN}

export NX_HOME_DIR=/var/lib/nxserver/home

pkg_setup () {
	enewuser nx -1 -1 ${NX_HOME_DIR}
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-nxloadconfig.patch
	epatch "${FILESDIR}"/${P}-cflags.patch
	epatch "${FILESDIR}"/${PN}-0.7.2-cups.patch

	sed	-e "/PATH_LIB=/s/lib/$(get_libdir)/g" \
		-e "s#REAL_PATH_LIB#/usr/$(get_libdir)/NX/bin#" \
		-i nxloadconfig || die "nxloadconfig sed failed"

	# Change the defaults in nxloadconfig to meet the users needs.
	if use arts ; then
		einfo "Enabling arts support."
		sed -i '/ENABLE_ARTSD_PRELOAD=/s/"0"/"1"/' nxloadconfig || die
		sed -i '/ENABLE_ARTSD_PRELOAD=/s/"0"/"1"/' node.conf.sample || die
	fi
	if use esd ; then
		einfo "Enabling esd support."
		sed -i '/ENABLE_ESD_PRELOAD=/s/"0"/"1"/' nxloadconfig || die
		sed -i '/ENABLE_ESD_PRELOAD=/s/"0"/"1"/' node.conf.sample || die
	fi
	if use cups ; then
		einfo "Enabling cups support."
		sed -i '/ENABLE_KDE_CUPS=/s/"0"/"1"/' nxloadconfig || die
		sed -i '/ENABLE_KDE_CUPS=/s/"0"/"1"/' node.conf.sample || die
	fi
}

src_compile() {
	emake CC=$(tc-getCC) CDEBUGFLAGS="${CFLAGS}" || die "compilation failed"
}

src_install() {
	export NX_ETC_DIR=/etc/nxserver
	export NX_SESS_DIR=/var/lib/nxserver/db

	emake DESTDIR="${D}" install || die "install failed"

	# This should be renamed to remove the blocker on net-misc/nxclient
	use nxclient && rm "${D}"/usr/bin/nxprint

	mv "${D}"/etc/nxserver/node.conf.sample "${D}"/etc/nxserver/node.conf ||
		die "cannot find default configuration file"

	dodir ${NX_ETC_DIR}
	for x in passwords passwords.orig ; do
		touch "${D}"${NX_ETC_DIR}/$x
		chmod 600 "${D}"${NX_ETC_DIR}/$x
	done

	dodir ${NX_HOME_DIR}

	for x in closed running failed ; do
		keepdir ${NX_SESS_DIR}/$x
		fperms 0700 ${NX_SESS_DIR}/$x
	done

	newinitd "${FILESDIR}"/nxserver.init nxserver
}

pkg_postinst () {
	# Other NX servers ebuilds may have already created the nx account
	# However they use different login shell/home directory paths
	if [[ ${ROOT} == "/" ]]; then
		usermod -s /usr/bin/nxserver nx || die "Unable to set login shell of nx user!!"
		usermod -d ${NX_HOME_DIR} nx || die "Unable to set home directory of nx user!!"
		usermod -a -G utmp nx || die "Unable to add nx user to utmp group!!"
	else
		elog "If you had another NX server installed before, please make sure"
		elog "the nx user account is correctly set to:"
		elog " * login shell: /usr/bin/nxserver"
		elog " * home directory: ${NX_HOME_DIR}"
		elog " * supplementary groups: utmp"
	fi

	elog "To complete the installation, run:"
	elog " nxsetup --install --setup-nomachine-key --clean --purge"
	elog "This will use the default Nomachine SSH key"
}
