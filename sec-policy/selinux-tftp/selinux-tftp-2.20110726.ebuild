# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-tftp/selinux-tftp-2.20110726.ebuild,v 1.1 2011/11/15 10:49:14 swift Exp $
EAPI="4"

IUSE=""
MODS="tftp"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for tftp"

KEYWORDS="~amd64 ~x86"
RDEPEND="!<=sec-policy/selinux-tftpd-2.20110726
	>=sys-apps/policycoreutils-2.1.0
	>=sec-policy/selinux-base-policy-2.20110726"
