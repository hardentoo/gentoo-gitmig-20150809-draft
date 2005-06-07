# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/vsftpd/vsftpd-2.0.3.ebuild,v 1.2 2005/06/07 23:04:57 uberlord Exp $

inherit flag-o-matic eutils pam

DESCRIPTION="Very Secure FTP Daemon written with speed, size and security in mind"
HOMEPAGE="http://vsftpd.beasts.org/"
SRC_URI="ftp://vsftpd.beasts.org/users/cevans/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="pam tcpd ssl xinetd"

DEPEND="pam? ( || ( virtual/pam sys-libs/pam ) )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	ssl? ( >=dev-libs/openssl-0.9.7d )"
RDEPEND="${DEPEND}
	xinetd? ( sys-apps/xinetd )"

src_unpack() {
	unpack "${A}" || die
	cd "${S}" || die
	epatch "${FILESDIR}/${PN}-2.0.1-gentoo.diff" || die

	use tcpd && echo "#define VSF_BUILD_TCPWRAPPERS" >> builddefs.h
	use ssl && echo "#define VSF_BUILD_SSL" >> builddefs.h
	use pam || echo "#undef VSF_BUILD_PAM" >> builddefs.h
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	into /usr
	doman vsftpd.conf.5 vsftpd.8
	dosbin vsftpd

	dodoc AUDIT BENCHMARKS BUGS Changelog FAQ INSTALL \
		LICENSE README README.security REWARD SIZE \
		SPEED TODO TUNING
	newdoc "${FILESDIR}/vsftpd.conf" vsftpd.conf.sample

	docinto security
	dodoc SECURITY/*

	insinto "/usr/share/doc/${PF}/examples"
	doins -r EXAMPLE/*

	insinto /etc/vsftpd
	doins "${FILESDIR}/ftpusers"
	newins "${FILESDIR}/vsftpd.conf" vsftpd.conf.sample

	if use xinetd ; then
		insinto /etc/xinetd.d
		newins "${FILESDIR}/vsftpd.xinetd" vsftpd
	fi

	if has_version "<sys-libs/pam-0.78" ; then
		newpamd "${FILESDIR}/vsftpd.pam" vsftpd
	else
		newpamd "${FILESDIR}/vsftpd.pam-include" vsftpd
	fi

	newconfd "${FILESDIR}/vsftpd.conf.d" vsftpd
	newinitd "${FILESDIR}/vsftpd.init.d" vsftpd

	keepdir /home/ftp
	keepdir /usr/share/vsftpd/empty
	keepdir /var/log/vsftpd
}

pkg_preinst() {
	# If we use xinetd, then we comment out background=YES and listen=YES
	# so that our default config works under xinetd - fixes #78347
	if use xinetd ; then
		sed -i '/\(background=YES\|listen=YES\)/s/^/#/g' \
			${IMAGE}/etc/vsftpd/vsftpd.conf.sample
	fi
}
