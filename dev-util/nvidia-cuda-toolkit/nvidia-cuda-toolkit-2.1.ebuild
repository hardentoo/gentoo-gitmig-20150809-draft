# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/nvidia-cuda-toolkit/nvidia-cuda-toolkit-2.1.ebuild,v 1.2 2009/04/13 19:18:46 spock Exp $

inherit eutils

DESCRIPTION="NVIDIA CUDA Toolkit"
HOMEPAGE="http://developer.nvidia.com/cuda"

BASE_URI="http://developer.download.nvidia.com/compute/cuda/2_1/toolkit/"
SRC_URI="amd64? ( ${BASE_URI}/cudatoolkit_2.1_linux64_suse11.0.run )
	x86? ( ${BASE_URI}/cudatoolkit_2.1_linux32_suse11.0.run )"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=""
RDEPEND=""
RESTRICT="strip"

S="${WORKDIR}"

src_unpack() {
	unpack_makeself
}

src_install() {
	local DEST=/opt/cuda
	export CONF_LIBDIR_OVERRIDE="lib"

	into ${DEST}
	dobin bin/*
	dolib lib/*

	chmod a-x "${D}/${DEST}/bin/nvcc.profile"

	# doman does not respect DESTTREE
	insinto ${DEST}/man/man1
	doins man/man1/*
	insinto ${DEST}/man/man3
	doins man/man3/*
	prepman ${DEST}

	insinto ${DEST}/include
	doins include/*.h
	insinto ${DEST}/include/crt
	doins include/crt/*.h

	insinto ${DEST}/src
	doins src/*

	into ${DEST}/open64
	dobin open64/bin/*
	libopts -m0755
	dolib open64/lib/*

	if use doc ; then
		insinto ${DEST}/doc
		doins doc/*
	fi

	cat > "${T}/env" << EOF
PATH=${DEST}/bin
ROOTPATH=${DEST}/bin
LDPATH=${DEST}/lib
MANPATH=${DEST}/man
EOF
	newenvd "${T}/env" 99cuda
}

pkg_postinst() {
	elog "If you want to natively run the code generated by CUDA, you will need"
	elog ">=x11-drivers/nvidia-drivers-180.22."
	elog ""
	elog "Run '. /etc/profile' before using the CUDA toolkit. "
}
