# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/kfilecoder/kfilecoder-0.6.0_pre1.ebuild,v 1.7 2002/10/04 03:50:28 vapier Exp $
inherit kde-base || die

S=${WORKDIR}/${P//_/-}

DESCRIPTION="Archiver with passwd management "
SRC_URI="http://download.sourceforge.net/kfilecoder/${P//_/-}.tar.bz2"
HOMEPAGE="http://kfilecoder.sourceforge.net"


LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

need-kde 3
