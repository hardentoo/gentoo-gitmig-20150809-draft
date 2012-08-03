# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/italc/italc-2.0.0.ebuild,v 1.4 2012/08/03 19:08:37 ago Exp $

EAPI=4

inherit qt4-r2 eutils cmake-utils user

DESCRIPTION="Intelligent Teaching And Learning with Computers (iTALC) supports working with computers in school"
HOMEPAGE="http://italc.sourceforge.net/"
SRC_URI="mirror://sourceforge/italc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/lzo
	dev-libs/openssl
	sys-apps/tcp-wrappers
	sys-libs/zlib
	virtual/jpeg
	x11-libs/qt-core:4
	x11-libs/qt-xmlpatterns:4
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libXtst
	x11-apps/xinput
	x11-libs/qt-gui:4"
DEPEND="${RDEPEND}
	x11-proto/inputproto"

PROPERTIES="interactive"

PATCHES=( "${FILESDIR}"/${P}-gcc-4.7.patch )

DOCS=( TODO README AUTHORS INSTALL ChangeLog )

pkg_setup() {
	enewgroup italc
}

pkg_postinst() {
	elog "On the master, please run "
	elog "# emerge --config =${CATEGORY}/${PF}"

	elog "Please add the logins of master users (teachers) to the italc group by running"
	elog "# usermod -a -G italc <loginname>"

	echo ""
}

pkg_config() {
	if [ ! -d /etc/italc/keys ] ; then
		einfo "Creating public and private keys for italc in /etc/italc/keys."
		/usr/bin/ica -role teacher -createkeypair > /dev/null
		eend $?
		einfo "Setting chmod 640 on private keys."
		chgrp -R italc /etc/italc
		chmod -R o-rwx /etc/italc/keys/private
	else
		einfo "Not creating new keypair, as /etc/italc/keys already exists"
	fi
}
