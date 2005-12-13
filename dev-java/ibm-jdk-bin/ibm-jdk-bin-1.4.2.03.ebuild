# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ibm-jdk-bin/ibm-jdk-bin-1.4.2.03.ebuild,v 1.6 2005/12/13 21:36:39 compnerd Exp $

inherit java eutils

if use x86 ; then
	JDK_DIST="IBMJava2-SDK-142.tgz"
	JDK_DIST_GENTOO="IBMJava2-SDK-142-SR3.tgz"
	JAVACOMM_DIST="IBMJava2-JAVACOMM-142.tgz"
	JAVACOMM_DIST_GENTOO="IBMJava2-JAVACOMM-142-SR3.tgz"
elif use amd64 ; then
	JDK_DIST="IBMJava2-SDK-AMD64-142.x86_64.tgz"
	JDK_DIST_GENTOO="IBMJava2-SDK-AMD64-142.x86_64-SR3.tgz"
	JAVACOMM_DIST="IBMJava2-JAVACOMM-AMD64-142.x86_64.tgz"
	JAVACOMM_DIST_GENTOO="IBMJava2-JAVACOMM-AMD64-142.x86_64-SR3.tgz"
elif use ppc ; then
	JDK_DIST="IBMJava2-SDK-142.ppc.tgz"
	JDK_DIST_GENTOO="IBMJava2-SDK-142.ppc-SR3.tgz"
	JAVACOMM_DIST="IBMJava2-JAVACOMM-142.ppc.tgz"
	JAVACOMM_DIST_GENTOO="IBMJava2-JAVACOMM-142.ppc-SR3.tgz"
elif use ppc64 ; then
	JDK_DIST="IBMJava2-SDK-142.ppc64.tgz"
	JDK_DIST_GENTOO="IBMJava2-SDK-142.ppc64-SR3.tgz"
	JAVACOMM_DIST="IBMJava2-JAVACOMM-142.ppc64.tgz"
	JAVACOMM_DIST_GENTOO="IBMJava2-JAVACOMM-142.ppc64-SR3.tgz"
fi

DESCRIPTION="IBM Java Development Kit"
HOMEPAGE="http://www-106.ibm.com/developerworks/java/jdk/"
SRC_URI="x86? ( IBMJava2-SDK-142-SR3.tgz )
		 amd64? ( IBMJava2-SDK-AMD64-142.x86_64-SR3.tgz )
		 ppc? ( IBMJava2-SDK-142.ppc-SR3.tgz )
		 ppc64? ( IBMJava2-SDK-142.ppc64-SR3.tgz )
		 javacomm? (
		 			x86? ( IBMJava2-JAVACOMM-142-SR3.tgz )
					amd64? ( IBMJava2-JAVACOMM-AMD64-142.x86_64-SR3.tgz )
					ppc? ( IBMJava2-JAVACOMM-142.ppc-SR3.tgz )
					ppc64? ( IBMJava2-JAVACOMM-142.ppc64-SR3.tgz )
		 		   )"

LICENSE="IBM-J1.4"
SLOT="1.4"
KEYWORDS="-* amd64 ppc ppc64 x86"
IUSE="X doc javacomm nsplugin"

DEPEND="virtual/libc
		>=dev-java/java-config-0.2.5
		X? ( || (
					(
						x11-libs/libXt
						x11-libs/libX11
						x11-libs/libXtst
						x11-libs/libXp
						x11-libs/libXext
						x11-libs/libSM
						x11-libs/libICE
						x11-libs/libXau
						x11-libs/libXdmcp
						x11-libs/libXi
						x11-libs/libXmu
					)
					virtual/x11
				)
			)"
RDEPEND="${DEPEND}
		 !ppc64? ( !amd64? ( sys-libs/lib-compat ) )"
PDEPEND="doc? ( =dev-java/java-sdk-docs-1.4.2* )"

PROVIDE="virtual/jdk
		 virtual/jre"

RESTRICT="fetch"

if use ppc; then
	S="${WORKDIR}/IBMJava2-ppc-142"
elif use ppc64; then
	S="${WORKDIR}/IBMJava2-ppc64-142"
elif use amd64; then
	S="${WORKDIR}/IBMJava2-amd64-142"
else
	S="${WORKDIR}/IBMJava2-142"
fi

pkg_nofetch() {
	einfo "Due to license restrictions, we cannot redistribute or fetch the distfiles"
	einfo "Please visit: ${HOMEPAGE}"
	einfo "Download: ${JDK_DIST}"
	if use javacomm ; then
		einfo "Download: ${JAVACOMM_DIST}"
	fi
	einfo "Rename ${JDK_DIST} to ${JDK_DIST_GENTOO}"
	if use javacomm ; then
		einfo "Rename ${JAVACOMM_DIST} to ${JAVACOMM_DIST_GENTOO}"
	fi
	einfo "Place the file(s) in: ${DISTDIR}"
	einfo "Then run emerge ${PN}"
}

pkg_setup() {
	einfo "The mozilla and browserplugin useflags have been dropped from this "
	einfo "version.  If you wish to use the browser plugin then please use the"
	einfo "nsplugin useflag"
	ebeep 5
}

src_compile() { :; }

src_install() {
	# The javaws execution script is 777 why?
	chmod 0755 ${S}/jre/javaws/javaws

	# Copy all the files to the designated directory
	mkdir -p ${D}opt/${P}
	cp -pR ${S}/{bin,jre,lib,include} ${D}opt/${P}/

	mkdir -p ${D}/opt/${P}/share
	cp -pPR ${S}/{demo,src.jar} ${D}opt/${P}/share/

	# setting the ppc stuff
	if use ppc; then
		dosed s:/proc/cpuinfo:/etc//cpuinfo:g /opt/${P}/jre/bin/libjitc.so
		dosed s:/proc/cpuinfo:/etc//cpuinfo:g /opt/${P}/jre/bin/libjitc_g.so
		insinto /etc
		doins ${FILESDIR}/cpuinfo
	fi

	if use nsplugin && ! use ppc && ! use amd64 && ! use ppc64; then
		local plugin="libjavaplugin_oji.so"

		if has_version '>=sys-devel/gcc-3' ; then
			plugin="libjavaplugin_ojigcc3.so"
		fi

		install_mozilla_plugin /opt/${P}/jre/bin/${plugin}
	fi

	dohtml -a html,htm,HTML -r docs
	dodoc ${S}/docs/COPYRIGHT

	set_java_env ${FILESDIR}/${VMHANDLE}
}

pkg_postinst() {
	java_pkg_postinst

	if ! use X; then
		eerror
		eerror "You have not enabled the X useflag.  It is possible that"
		eerror "you do not have an X server installed.  Please note that"
		eerror "some parts of the IBM JDK require an X server to properly"
		eerror "function.  Be careful which Java libraries you attempt to"
		eerror "use with your installation."
		eerror
	fi
}
