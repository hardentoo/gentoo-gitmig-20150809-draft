# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.16.90.0.2.ebuild,v 1.2 2005/05/06 02:33:47 vapier Exp $

PATCHVER="1.1"
UCLIBC_PATCHVER="1.0"
inherit toolchain-binutils

# ARCH - packages to test before marking
# ia64 - elilo
KEYWORDS="-*"
