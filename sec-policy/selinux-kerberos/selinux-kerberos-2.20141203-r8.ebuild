# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-kerberos/selinux-kerberos-2.20141203-r8.ebuild,v 1.1 2015/08/04 17:42:10 perfinion Exp $
EAPI="5"

IUSE=""
MODS="kerberos"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for kerberos"

if [[ $PV == 9999* ]] ; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi
