# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/file/file-4.09.ebuild,v 1.6 2004/06/24 22:06:15 agriffis Exp $

inherit flag-o-matic gnuconfig eutils
use python && inherit distutils

DESCRIPTION="Program to identify a file's format by scanning binary data for patterns"
HOMEPAGE="ftp://ftp.astron.com/pub/file/"
SRC_URI="ftp://ftp.gw.com/mirrors/pub/unix/file/${P}.tar.gz
	ftp://ftp.astron.com/pub/file/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips alpha ~arm ~hppa amd64 ~ia64 ~ppc64 s390"
IUSE="python build"

DEPEND="virtual/glibc
	!build? ( python? ( virtual/python ) )"

src_unpack() {
	unpack ${A}
	cd ${S}

	# (12 Oct 2003) <kumba@gentoo.org>
	# This patch is for MIPS only.  It slightly changes the 'file' output
	# on MIPS machines to a specific format so that other programs can
	# recognize things.
	use mips && epatch ${FILESDIR}/${PN}-4.xx-mips-gentoo.diff
}

src_compile() {
	# If running mips64, we need updated configure data
	use mips && gnuconfig_update

	# file command segfaults on hppa -  reported by gustavo@zacarias.com.ar
	[ ${ARCH} = "hppa" ] && filter-flags "-mschedule=8000"

	econf --datadir=/usr/share/misc || die

	# Buggy Makefiles.  This fixes bug 31356
	emake -j1 || die "emake failed"

	use python && cd python && distutils_src_compile
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	if ! use build ; then
		dodoc ChangeLog MAINT README
		use python && cd python && distutils_src_install
	else
		rm -rf ${D}/usr/share/man
	fi
}

pkg_postinst() {
	use python && distutils_pkg_postinst
}

pkg_postrm() {
	use python && distutils_pkg_postrm
}
