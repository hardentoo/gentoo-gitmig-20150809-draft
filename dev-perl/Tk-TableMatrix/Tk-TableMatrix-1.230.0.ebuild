# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tk-TableMatrix/Tk-TableMatrix-1.230.0.ebuild,v 1.1 2011/08/28 11:07:46 tove Exp $

EAPI=4

MODULE_AUTHOR=CERNEY
MODULE_VERSION=1.23
inherit perl-module

DESCRIPTION="Perl module for Tk-TableMatrix"

#SRC_TEST="do"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-perl/perl-tk"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/pTk-1.22.patch" )

src_install() {
	perl-module_src_install

	# Clean out stray conflicting file - its generated by perl-tk already.
	# Bug 169294
	rm	"${D}"/${VENDOR_ARCH}/auto/Tk/pTk/extralibs.ld || die
}
