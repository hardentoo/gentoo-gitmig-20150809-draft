# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/xmms-themes/xmms-themes-0.0.1.ebuild,v 1.2 2002/10/22 15:45:01 bjb Exp $

DESCRIPTION="Collection of XMMS themes"
HOMEPAGE="http://www.xmms.org"
THEME_URI="http://www.xmms.org/files/Skins"
SRC_URI="${THEME_URI}/AbsoluteE_Xmms.zip
	${THEME_URI}/Absolute_Blue-XMMS.zip
	${THEME_URI}/AdamAmp.zip
	${THEME_URI}/Apple_Platinum_Amp.zip
	${THEME_URI}/Aqua.zip
	${THEME_URI}/BlackXMMS.zip
	${THEME_URI}/BlueIce.zip
	${THEME_URI}/BlueSteel.zip
	${THEME_URI}/BlueSteel_xmms.zip
	${THEME_URI}/BrushedMetal_Xmms.zip
	${THEME_URI}/CX2.zip
	${THEME_URI}/ConceptX-Gold.zip
	${THEME_URI}/Concept_X.zip
	${THEME_URI}/Covenant.zip
	${THEME_URI}/Cyrus-XMMS.zip
	${THEME_URI}/FB_1.2.zip
	${THEME_URI}/FB_2.1.zip
	${THEME_URI}/FreeBSD.zip
	${THEME_URI}/Freshmeat_Amp.zip
	${THEME_URI}/GTK+.zip
	${THEME_URI}/Ghost-10.zip
	${THEME_URI}/HeliXMMS.zip
	${THEME_URI}/Inverse.zip
	${THEME_URI}/Marble.zip
	${THEME_URI}/NeXTAmp2-1.0pre1.zip
	${THEME_URI}/NeXTAmp2.4.zip
	${THEME_URI}/OmniAMP-1.3.zip
	${THEME_URI}/Panic.zip
	${THEME_URI}/Plume-XMMS-v1.zip
	${THEME_URI}/SuedE.zip
	${THEME_URI}/Ultrafina-pw.zip
	${THEME_URI}/Ultrafina.zip
	${THEME_URI}/Ultrafina2000.zip
	${THEME_URI}/UltrafinaSE.zip
	${THEME_URI}/UltrafinaSEM.zip
	${THEME_URI}/Vegetal_Blues.zip
	${THEME_URI}/Vegetali_1-1.zip
	${THEME_URI}/Vulcan.zip
	${THEME_URI}/Vulcan21.zip
	${THEME_URI}/WoodPanel.zip
	${THEME_URI}/X-Tra.zip
	${THEME_URI}/XMMS-AfterStep.zip
	${THEME_URI}/XMMS-Green.zip
	${THEME_URI}/XawMMS.zip
	${THEME_URI}/arctic_Xmms.zip
	${THEME_URI}/blackstar.zip
	${THEME_URI}/blueHeart-xmms-20.zip
	${THEME_URI}/blueHeart_Xmms.zip
	${THEME_URI}/bmXmms.zip
	${THEME_URI}/cart0onix.zip
	${THEME_URI}/chaos_XMMS.zip
	${THEME_URI}/cherry.zip
	${THEME_URI}/cracked.zip
	${THEME_URI}/detone_blue.zip
	${THEME_URI}/detone_green.zip
	${THEME_URI}/eMac-XMMS.zip
	${THEME_URI}/eMac_Xmms_color_schemes.zip
	${THEME_URI}/fyre.zip
	${THEME_URI}/gLaNDAmp-2.0.zip
	${THEME_URI}/minEguE-xmms-v2.zip
	${THEME_URI}/myway.zip
	${THEME_URI}/nuance-2.0.zip
	${THEME_URI}/nuance-green-2.0.zip
	${THEME_URI}/sinistar.zip
	${THEME_URI}/spiffMEDIA.zip
	${THEME_URI}/titanium.zip
	${THEME_URI}/xmms-256.zip
	${THEME_URI}/Cobalt-Obscura.tar.gz
	${THEME_URI}/ColderXMMS.tar.gz
	${THEME_URI}/Coolblue.tar.gz
	${THEME_URI}/Eclipse.tar.gz
	${THEME_URI}/LinuxDotCom.tar.gz
	${THEME_URI}/MarbleX.tar.gz
	${THEME_URI}/NoerdAmp-SE.tar.gz
	${THEME_URI}/Winamp_X_XMMS_1.01.tar.gz
	${THEME_URI}/cherry_best.tar.gz
	${THEME_URI}/fiRe.tar.gz
	${THEME_URI}/m2n.tar.gz
	${THEME_URI}/maXMMS.tar.gz
	${THEME_URI}/nixamp2.tar.gz
	${THEME_URI}/sword.tar.gz
	${THEME_URI}/xmmearth.tar.gz"

#	${THEME_URI}/ions.tar.gz
#	${THEME_URI}/minEguE-xmms-v1.tar.gz
#	${THEME_URI}/Helix-Sawfish-xmms.tar.gz

LICENSE="Freeware"
SLOT="0"
KEYWORDS="* alpha"
DEPEND="net-misc/wget"
RDEPEND="media-sound/xmms
	app-arch/unzip"
S=${WORKDIR}/${P}

src_unpack() {
	local bn
	mkdir ${S}
	cd ${S}
	for i in ${SRC_URI} ; do
		bn=`basename $i`
		if [ -n "`echo ${bn} | grep '\.zip'`" ] ; then
			cp ${DISTDIR}/${bn} .
		else
			unpack ${bn}
		fi
	done
}

src_compile() {
	einfo "No compilation necessary."
}

src_install () {
	dodir /usr/share/xmms/Skins
	cp -dpR * ${D}/usr/share/xmms/Skins/
}
