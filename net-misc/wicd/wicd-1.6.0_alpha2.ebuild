# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/wicd/wicd-1.6.0_alpha2.ebuild,v 1.1 2009/04/25 04:41:23 darkside Exp $

EAPI="2"

inherit distutils eutils

MY_P=${P/_alpha/a}

DESCRIPTION="A lightweight wired and wireless network manager for Linux"
HOMEPAGE="http://wicd.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ioctl"

DEPEND=""
RDEPEND="
	dev-python/dbus-python
	dev-python/pygtk
	>=dev-python/urwid-0.9.8.4
	|| (
		net-misc/dhcpcd
		net-misc/dhcp
		net-misc/pump
	)
	net-wireless/wireless-tools
	net-wireless/wpa_supplicant
	|| (
		sys-apps/net-tools
		sys-apps/ethtool
	)
	|| (
		x11-misc/ktsuss
		x11-libs/gksu
		kde-base/kdesu
	)
	>=sys-power/pm-utils-1.1.1
	ioctl? ( dev-python/python-iwscan dev-python/python-wpactrl )
	"

S="${WORKDIR}/${MY_P}"

src_compile() {
	${python} ./setup.py configure --no-install-docs --resume=/usr/share/wicd/scripts/ --suspend=/usr/share/wicd/scripts/ --verbose
	distutils_src_compile
}

src_install() {
	DOCS="CHANGES"
	distutils_src_install
	newinitd "${FILESDIR}/wicd-init.d" wicd || die "newinitd failed"
	keepdir /var/lib/wicd/configurations || die "keepdir failed, critical for this app"
}

pkg_postinst() {
	distutils_pkg_postinst

	elog "You may need to restart the dbus service after upgrading wicd."
	echo
	elog "To start wicd at boot, add /etc/init.d/wicd to a runlevel and:"
	elog "- Remove all net.* initscripts (except for net.lo) from all runlevels"
	elog "- Add these scripts to the RC_PLUG_SERVICES line in /etc/conf.d/rc"
	elog "(For example, RC_PLUG_SERVICES=\"!net.eth0 !net.wlan0\")"
}
