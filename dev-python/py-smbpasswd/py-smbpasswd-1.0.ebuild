# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py-smbpasswd/py-smbpasswd-1.0.ebuild,v 1.7 2006/04/01 15:15:32 agriffis Exp $

inherit distutils

DESCRIPTION="This module can generate both LANMAN and NT password hashes, suitable for use with Samba."
HOMEPAGE="http://barryp.org/software/py-smbpasswd/"
SRC_URI="http://barryp.org/software/py-smbpasswd/files/py-smbpasswd-1.0.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ia64 ppc ~sparc x86"
IUSE=""

DEPEND="virtual/python"
