# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fail2ban/fail2ban-0.6.0.ebuild,v 1.6 2006/03/07 10:02:08 jer Exp $

DESCRIPTION="Bans IP that make too many password failures"
HOMEPAGE="http://sourceforge.net/projects/fail2ban"
SRC_URI="mirror://sourceforge/fail2ban/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4"

src_install() {
	# Use python setup
	python setup.py install --root="${D}" || die

	# Use fail2ban.conf.default as default config file
	insinto /etc
	newins config/fail2ban.conf.default fail2ban.conf
	# Install initd scripts
	exeinto /etc/init.d
	newexe config/gentoo-initd fail2ban
	insinto /etc/conf.d
	newins config/gentoo-confd fail2ban
	# Doc
	doman man/*.[0-9]
	dodoc CHANGELOG README TODO
}

pkg_postinst() {
	einfo "Please edit /etc/fail2ban.conf with parameters"
	einfo "that correspond to your system."
}
