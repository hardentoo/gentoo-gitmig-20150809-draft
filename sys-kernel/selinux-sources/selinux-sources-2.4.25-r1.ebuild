# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/selinux-sources/selinux-sources-2.4.25-r1.ebuild,v 1.1 2004/04/15 06:44:08 plasmaroo Exp $

ETYPE="sources"
inherit kernel-2
detect_version
IUSE=""

GPV_SRC="mirror://gentoo/patches-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-selinux-${PR/1/0}.tar.bz2"
KEYWORDS="-* x86"

UNIPATCH_LIST="${DISTDIR}/patches-${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-selinux-${PR/1/0}.tar.bz2 ${FILESDIR}/${P}.CAN-2004-0109.patch"

DESCRIPTION="Base ${KV_MAJOR}.${KV_MINOR}.${KV_PATCH} SELinux kernel"
SRC_URI="${KERNEL_URI} ${GPV_SRC}"
HOMEPAGE="http://www.kernel.org/ http://www.nsa.gov/selinux"
