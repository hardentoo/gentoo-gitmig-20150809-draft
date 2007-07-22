# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-java/emul-linux-x86-java-1.6.0-r1.ebuild,v 1.3 2007/07/22 09:18:53 omp Exp $

inherit pax-utils java-vm-2 eutils

#MY_PVL=${PV%.*}_${PV##*.}
#MY_PVA=${PV//./_}

#At="jdk-${MY_PVA}-dlj-linux-i586.bin"
At="jdk-6-dlj-linux-i586.bin"
DESCRIPTION="32bit version Sun's J2SE Development Kit"
HOMEPAGE="http://java.sun.com/j2se/1.6.0/"
SRC_URI="http://download.java.net/dlj/binaries/${At}"

SLOT="1.6"
LICENSE="dlj-1.1"
KEYWORDS="-* ~amd64"
RESTRICT="strip"
IUSE="X alsa nsplugin"

JAVA_VM_NO_GENERATION1=true

RDEPEND="alsa? ( media-libs/alsa-lib )
	X? ( x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libXp
		x11-libs/libXt
		x11-libs/libXtst )"

JAVA_PROVIDE="jdbc-stdext jdbc-rowset"

PACKED_JARS="lib/rt.jar lib/jsse.jar lib/charsets.jar lib/ext/localedata.jar lib/plugin.jar lib/javaws.jar lib/deploy.jar"

QA_TEXTRELS_amd64="opt/${P}/lib/i386/motif21/libmawt.so
	opt/${P}/lib/i386/libdeploy.so
	opt/${P}/lib/i386/client/libjvm.so
	opt/${P}/lib/i386/server/libjvm.so"

src_unpack() {
	if [[ ! -r ${DISTDIR}/${At} ]]; then
		die "cannot read ${At}. Please check the permission and try again."
	fi

	mkdir bundled-jdk
	cd bundled-jdk
	sh ${DISTDIR}/${At} --accept-license --unpack || die "Failed to unpack"

	cd ..
	bash ${FILESDIR}/construct-${SLOT}.sh  bundled-jdk sun-jdk-${PV} ${P} || die "construct-${SLOT}.sh failed"

	${S}/bin/java -client -Xshare:dump
}

src_install() {
	local dirs="bin lib man javaws plugin"
	dodir /opt/${P}

	for i in $dirs ; do
		cp -pPR $i ${D}/opt/${P}/ || die "failed to copy"
	done

	pax-mark m $(list-paxables "${D}"/opt/${P}/bin/*)

	dodoc  README THIRDPARTYLICENSEREADME.txt || die
	dohtml Welcome.html
	dodir /opt/${P}/share/

	if use nsplugin; then
		local plugin_dir="ns7-gcc29"
		if has_version '>=sys-devel/gcc-3' ; then
			plugin_dir="ns7"
		fi

		install_mozilla_plugin /opt/${P}/plugin/i386/$plugin_dir/libjavaplugin_oji.so
	fi

	# FIXME figure out how to handle the control pannel conflict with
	# sun-jdk-bin

	# install control panel for Gnome/KDE
#	sed -e "s/INSTALL_DIR\/JRE_NAME_VERSION/\/opt\/${P}\/jre/" \
#		-e "s/\(Name=Java\)/\1 Control Panel ${SLOT}/" \
#		${D}/opt/${P}/plugin/desktop/sun_java.desktop > \
#		${T}/sun_java-${SLOT}.desktop

#	domenu ${T}/sun_java-${SLOT}.desktop

	set_java_env
}

pkg_postinst() {
	# Set as default VM if none exists
	java-vm-2_pkg_postinst

	if ! use X; then
		local xwarn="virtual/x11 and/or"
	fi

	echo
	ewarn "Some parts of Sun's JDK require ${xwarn} virtual/lpr to be installed."
	ewarn "Be careful which Java libraries you attempt to use."
}
