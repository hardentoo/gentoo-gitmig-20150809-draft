# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-sensors/xfce4-sensors-0.10.99.3-r2.ebuild,v 1.1 2008/06/05 12:45:27 drac Exp $

inherit eutils xfce44

xfce44

DESCRIPTION="acpi, lm_sensors and hddtemp panel plugin"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="acpi debug hddtemp lm_sensors"

RDEPEND="lm_sensors? ( sys-apps/lm_sensors )
	hddtemp? ( app-admin/hddtemp )"
DEPEND="dev-util/intltool"

pkg_setup() {
	XFCE_CONFIG+=" $(use_enable hddtemp)
		$(use_enable lm_sensors libsensors)
		$(use_enable acpi procacpi)"

	if ! use hddtemp && ! use lm_sensors && ! use acpi; then
		XFCE_CONFIG+=" --enable-procacpi"
		ewarn "Because you disabled all USE flags, selecting acpi for you."
	fi

	DOCS="AUTHORS ChangeLog NEWS NOTES README TODO"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-hddtemp.patch
}

xfce44_goodies_panel_plugin
