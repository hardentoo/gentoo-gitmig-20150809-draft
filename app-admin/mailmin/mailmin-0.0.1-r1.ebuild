#//Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/mailmin/mailmin-0.0.1-r1.ebuild,v 1.1 2004/04/12 00:10:08 klasikahl Exp $

inherit webapp-apache

DESCRIPTION="Mailmin is a PHP frontend to the virtual mail database that is needed in the Virtual/Mailhost Postfix Howto."

HOMEPAGE="http://gentoo.org/proj/en/virt-mail-admin.xml"

SRC_URI="mirror://gentoo/${P}-pre2-alpha.tar.bz2
		http://dev.gentoo.org/~klasikahl/mailmin/${P}-pre2-alpha.tar.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND="virtual/php
	crypt? ( app-crypt/gnupg )
	ldap? ( net-nds/openldap )"

webapp-detect || NO_WEBSERVER=1

S=${WORKDIR}/${P}-pre2-alpha/mail

pkg_setup() {
	webapp-pkg_setup "${NO_WEBSERVER}"
	if [ -L ${HTTPD_ROOT}/${PN} ] ; then
		ewarn "You need to unmerge your old virt-mail-admin version first."
		ewarn "virt-mail-admin will be installed into ${HTTPD_ROOT}/${PN}"
		ewarn "directly instead of a version-dependant directory."
		die "need to unmerge old version first"
	fi
	einfo "Installing into ${ROOT}${HTTPD_ROOT}."
}

src_unpack() {
	unpack ${P}-pre2-alpha.tar.bz2
}

src_compile() {
	:;
}

src_install() {

	webapp-mkdirs

	local DocumentRoot=${HTTPD_ROOT}
	local destdir=${DocumentRoot}/${PN}
	dodir ${destdir}
	cp -r . ${D}/${HTTPD_ROOT}/${PN}
	cd ${D}/${HTTPD_ROOT}
	chown -R ${HTTPD_USER}:${HTTPD_GROUP} ${PN}
}

pkg_postinst() {
	ewarn
	ewarn "Make sure to run http://domain.tld/${PN}/install.php FIRST"
	ewarn
}
