# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu/kdeedu-3.2.2.ebuild,v 1.5 2004/05/15 15:27:20 weeve Exp $

inherit kde-dist eutils

DESCRIPTION="KDE educational apps"

KEYWORDS="x86 ~ppc sparc ~alpha ~hppa ~amd64 ~ia64"

src_unpack()
{
	kde_src_unpack
	epatch ${FILESDIR}/${P}-gcc34-compile.patch
}

