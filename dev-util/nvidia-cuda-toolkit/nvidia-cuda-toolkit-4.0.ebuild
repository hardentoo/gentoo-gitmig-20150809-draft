# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/nvidia-cuda-toolkit/nvidia-cuda-toolkit-4.0.ebuild,v 1.4 2011/08/23 18:54:11 spock Exp $

EAPI=2

inherit eutils multilib

DESCRIPTION="NVIDIA CUDA Toolkit"
HOMEPAGE="http://developer.nvidia.com/cuda"
RESTRICT="binchecks"

CUDA_V=${PV//_/-}
DIR_V=${CUDA_V//./_}
DIR_V=${DIR_V//beta/Beta}

BASE_URI="http://developer.download.nvidia.com/compute/cuda/${DIR_V}/toolkit"
SRC_URI="amd64? ( ${BASE_URI}/cudatoolkit_${CUDA_V}.17_linux_64_ubuntu10.10.run )
	x86? ( ${BASE_URI}/cudatoolkit_${CUDA_V}.17_linux_32_ubuntu10.10.run )"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debugger doc profiler"

RDEPEND="${DEPEND}
	>=sys-devel/binutils-2.20
	sys-devel/gcc:4.4
	profiler? ( x86? (
		x11-libs/qt-gui
		x11-libs/qt-core
		x11-libs/qt-assistant[compat]
		x11-libs/qt-sql[sqlite] )
		media-libs/libpng:1.2
	)
	debugger? ( >=sys-libs/libtermcap-compat-2.0.8-r2 )
	!<=x11-drivers/nvidia-drivers-270.41"

S="${WORKDIR}"

#QA_DT_HASH_x86="opt/cuda/.*"
#QA_DT_HASH_amd64="opt/cuda/.*"

src_unpack() {
	for f in ${A} ; do
		if [ "${f//*.run/}" == "" ]; then
			unpack_makeself ${f}
		fi
	done
}

src_install() {
	local DEST=/opt/cuda

	into ${DEST}
	dobin bin/*
	dolib $(get_libdir)/*

	if ! use debugger; then
		rm -f "${D}/${DEST}/bin/cuda-gdb"
	fi

	chmod a-x "${D}/${DEST}/bin/nvcc.profile"

	# TODO: Manuals are missing from this release. Remove the following
	# commented-out lines if they are not restored in the next releases.
	# doman does not respect DESTTREE
	#insinto ${DEST}/man/man1
	#doins man/man1/*
	#insinto ${DEST}/man/man3
	#doins man/man3/*
	#prepman ${DEST}

	insinto ${DEST}/include
	doins -r include/*

	insinto ${DEST}/src
	doins src/*

	if use doc ; then
		insinto ${DEST}/doc
		doins -r doc/*
	fi

	cat > "${T}/env" << EOF
PATH=${DEST}/bin
ROOTPATH=${DEST}/bin
LDPATH=${DEST}/$(get_libdir)
MANPATH=${DEST}/man
EOF
	newenvd "${T}/env" 99cuda

	if use profiler; then
		local target="computeprof"

		into ${DEST}/${target}
		dobin ${target}/bin/${target}

		cat > "${T}/env" << EOF
PATH=${DEST}/${target}/bin
ROOTPATH=${DEST}/${target}/bin
EOF
		if use x86 ; then
			dosym /usr/bin/assistant ${DEST}/${target}/bin

			insinto ${DEST}/${target}/bin
			doins ${target}/bin/cudaapitrace32.so
		else
			dobin ${target}/bin/assistant
			insinto ${DEST}/${target}/bin
			doins ${target}/bin/*.so*
			insinto ${DEST}/${target}/bin/sqldrivers
			doins ${target}/bin/sqldrivers/*

			cat >> "${T}/env" << EOF
LDPATH=${DEST}/${target}/bin
EOF
		fi

		newenvd "${T}/env" 99${target}

		if use doc; then
			insinto ${DEST}/${target}
			doins ${target}/*.txt
			insinto ${DEST}/${target}/doc
			doins ${target}/doc/*
			insinto ${DEST}/${target}/projects
			doins ${target}/projects/*
		fi

		make_desktop_entry /opt/cuda/computeprof/bin/computeprof "NVIDIA Compute Visual Profiler"
	fi

	export CONF_LIBDIR_OVERRIDE="lib"
	# HACK: temporary workaround until CONF_LIBDIR_OVERRIDE is respected.
	export LIBDIR_amd64="lib"

	into ${DEST}/open64
	dobin open64/bin/*
	libopts -m0755
	dolib open64/lib/*

	# TODO: ideally, there would be multiple OpenCL implementations available in
	# the tree and an eselect module would allow to switch between them.
	into /
	dosym /opt/cuda/include/CL usr/include/CL
}

pkg_postinst() {
	env-update
	elog "If you want to natively run the code generated by this version of the"
	elog "CUDA toolkit, you will need >=x11-drivers/nvidia-drivers-260.19.21."
	elog ""
	elog "Run '. /etc/profile' before using the CUDA toolkit. "
}
