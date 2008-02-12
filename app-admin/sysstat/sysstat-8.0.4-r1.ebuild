# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sysstat/sysstat-8.0.4-r1.ebuild,v 1.3 2008/02/12 19:06:41 opfer Exp $

inherit eutils multilib

DESCRIPTION="System performance tools for Linux"
HOMEPAGE="http://perso.wanadoo.fr/sebastien.godard/"
SRC_URI="http://perso.orange.fr/sebastien.godard/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ppc ~ppc64 ~sparc x86"
IUSE="nls"

RDEPEND="nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	sa_lib_dir=/usr/$(get_libdir)/sa \
		econf $(use_enable nls) conf_dir=/etc || die "econf failed"
	emake LFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	keepdir /var/log/sa

	emake DESTDIR="${D}" DOC_DIR=/usr/share/doc/${PF} \
		install || die "make install failed"

	newdoc sysstat.crond.sample crontab.example
	newinitd "${FILESDIR}"/sysstat.init.d sysstat

	ewarn "The sysstat configuration files have moved from /etc/sysconfig to /etc"
}
