# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/nforce-audio/nforce-audio-1.0.0310.ebuild,v 1.1 2005/12/13 00:41:08 metalgod Exp $

inherit eutils linux-mod

PKG_V="pkg1"
NV_V="${PV/1.0./1.0-}"
X86_NV_PACKAGE="NFORCE-Linux-x86-${NV_V}"
AMD64_NV_PACKAGE="NFORCE-Linux-x86_64-${NV_V}"

DESCRIPTION="Linux kernel module for the NVIDIA's nForce SoundStorm audio chipset"
HOMEPAGE="http://www.nvidia.com/"
SRC_URI="x86? ( http://download.nvidia.com/XFree86/nforce/${NV_V}/${X86_NV_PACKAGE}-${PKG_V}.run )
	amd64? ( http://download.nvidia.com/XFree86/nforce/amd64/${NV_V}/${AMD64_NV_PACKAGE}-${PKG_V}.run )"

if use x86; then
	NV_PACKAGE="${X86_NV_PACKAGE}"
elif use amd64; then
	NV_PACKAGE="${AMD64_NV_PACKAGE}"
fi

S=${WORKDIR}/${NV_PACKAGE}-${PKG_V}/nvsound

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
RESTRICT="nostrip"
IUSE=""

MODULE_NAMES="nvsound(:${S}/main)"
BUILD_PARAMS="SYSSRC=${KV_DIR}"
BUILD_TARGETS=" "

src_unpack() {
	unpack ${A}

	cd ${WORKDIR}
	bash ${DISTDIR}/${NV_PACKAGE}-${PKG_V}.run --extract-only
}

src_compile() {
	cd ${S}/main

	if kernel_is 2 6
	then
		rm makefile
		ln -snf Makefile.kbuild Makefile
	fi

	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
	dobin nvmixer nvmix-reg
	dodoc ${S}/ReleaseNotes.html
}

pkg_postinst() {
	linux-mod_pkg_postinst

	einfo "If you want to restore your volume settings between sessions add this line to your"
	einfo "/etc/conf.d/local.start:"
	einfo "/usr/bin/nvmix-reg -f /etc/nvmixrc -L >/dev/null 2>&1"
	einfo "And this line to your /etc/conf.d/local.stop"
	einfo "/usr/bin/nvmix-reg -f /etc/nvmixrc -S >/dev/null 2>&1"
}
