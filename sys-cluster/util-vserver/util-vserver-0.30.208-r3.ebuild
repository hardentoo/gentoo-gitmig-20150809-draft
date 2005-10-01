# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/util-vserver/util-vserver-0.30.208-r3.ebuild,v 1.3 2005/10/01 18:07:36 hollow Exp $

inherit autotools eutils toolchain-funcs

DESCRIPTION="Linux-VServer admin utilities"
HOMEPAGE="http://www.nongnu.org/util-vserver/"
SRC_URI="http://www.13thfloor.at/~ensc/util-vserver/files/alpha/${P}.tar.bz2 \
	http://dev.gentoo.org/~hollow/vserver/${PN}/${P}-gentoo-${PR}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND=">=dev-libs/dietlibc-0.28
	dev-libs/beecrypt
	net-firewall/iptables
	net-misc/vconfig
	sys-apps/iproute2
	sys-process/procps"

pkg_setup() {
	if [[ -z "${VDIRBASE}" ]]; then
		einfo
		einfo "You can change the default vserver base directory (/vservers)"
		einfo "by setting the VDIRBASE environment variable."
	fi

	: ${VDIRBASE:=/vservers}

	einfo
	einfo "Using \"${VDIRBASE}\" as vserver base directory"
	einfo
}

src_unpack() {
	unpack ${A} || die
	cd "${S}" || die

	epatch "${WORKDIR}"/patches/*.patch
	
	cd "${WORKDIR}"
	epatch "${FILESDIR}"/vserver-new_dev-fix.patch
	cd - &>/dev/null

	AT_M4DIR="-I m4" \
	eautoreconf
}

src_compile() {
	econf --localstatedir=/var \
	      --with-initrddir=/etc/init.d \
	      --with-vrootdir="${VDIRBASE}" || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"

	# keep dirs
	keepdir /var/run/vservers
	keepdir /var/run/vservers.rev
	keepdir /var/run/vshelper
	keepdir /var/lock/vservers

	keepdir "${VDIRBASE}"
	fperms 000 "${VDIRBASE}"

	# remove the non-gentoo init-scripts:
	rm -f "${D}"/etc/init.d/*

	# and install gentoo'ized ones:
	doinitd "${WORKDIR}"/init.d/{vservers,vprocunhide}
	doconfd "${WORKDIR}"/conf.d/vservers

	# install some usefull gentoo vserver scripts
	dosbin "${WORKDIR}"/tools/*

	dodoc README ChangeLog NEWS AUTHORS INSTALL THANKS util-vserver.spec
}

pkg_postinst() {
	einfo
	einfo "You have to run the vprocunhide command after every reboot"
	einfo "in order to setup /proc permissions correctly for vserver"
	einfo "use. An init script has been installed by this package."
	einfo "To use it you should add it to a runlevel:"
	einfo
	einfo " rc-update add vserver default"
	einfo
	einfo "This init script will also help you to start/stop your vservers"
	einfo "on reboot. See ${ROOT}etc/conf.d/vserver for details"
	ewarn
	ewarn "You should definitly fix up the barrier of your vserver"
	ewarn "base directory by using the following command in a root shell:"
	ewarn
	ewarn " setattr --barrier ${VDIRBASE}"
	ewarn
}
