# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-spamassassin/selinux-spamassassin-20040704.ebuild,v 1.3 2005/01/20 09:38:58 kaiowas Exp $

TEFILES="spamassassin.te spamc.te spamd.te"
FCFILES="spamassassin.fc spamc.fc spamd.fc"
MACROS="spamassassin_macros.te"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for SpamAssassin"

KEYWORDS="x86 ppc sparc amd64"

