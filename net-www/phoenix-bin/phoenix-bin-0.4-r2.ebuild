# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/phoenix-bin/phoenix-bin-0.4-r2.ebuild,v 1.3 2002/11/21 22:48:44 gerk Exp $

IUSE=""

MY_PN=${PN/-bin/}
S=${WORKDIR}/${MY_PN}
DESCRIPTION="The Phoenix Web Browser"
SRC_URI="http://ftp.mozilla.org/pub/${MY_PN}/releases/${PV}/${MY_PN}-${PV}-i686-pc-linux-gnu.tar.gz"
HOMEPAGE="http://www.mozilla.org/projects/phoenix/"
RESTRICT="nostrip"

KEYWORDS="x86 -ppc -sparc -sparc64 -alpha"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"

DEPEND="virtual/glibc"
RDEPEND=">=sys-libs/lib-compat-1.0-r2
	 >=x11-libs/gtk+-1.2.10-r9
	 virtual/x11"

src_install() {
	# Plugin path creation
	PLUGIN_DIR="/usr/lib/nsbrowser/plugins" 
	mkdir -p ${D}/${PLUGIN_DIR}

	dodir /usr/lib

	mv ${S} ${D}/usr/lib

	# Plugin path setup (rescuing the existent plugins)
	mv ${D}/usr/lib/${MY_PN}/plugins ${D}/usr/lib/${MY_PN}/plugins.temp
	dosym ../nsbrowser/plugins /usr/lib/${MY_PN}/
	mv ${D}/usr/lib/${MY_PN}/plugins.temp/* ${D}/usr/lib/${MY_PN}/plugins/
	rmdir ${D}/usr/lib/${MY_PN}/plugins.temp

	# Fixing permissions
	chown -R root.root ${D}/usr/lib/${MY_PN}

	# Truetype fonts
        cd ${D}/usr/lib/${MY_PN}/defaults/pref
        einfo "Enabling truetype fonts"
        patch < ${FILESDIR}/phoenix-0.4-antialiasing-patch

	# Misc stuff
	dobin ${FILESDIR}/phoenix
	dosym /usr/lib/libstdc++-libc6.1-1.so.2 /usr/lib/${MY_PN}/libstdc++-libc6.2-2.so.3
}

pkg_preinst() {
	# Remove the old plugins dir
	[ -d /usr/lib/phoenix/plugins ] && rm -r /usr/lib/phoenix/plugins
}
