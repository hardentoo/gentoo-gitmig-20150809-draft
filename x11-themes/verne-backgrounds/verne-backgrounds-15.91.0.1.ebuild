# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/verne-backgrounds/verne-backgrounds-15.91.0.1.ebuild,v 1.1 2011/08/13 23:43:32 flameeyes Exp $

EAPI=3

inherit versionator rpm

SRC_PATH=development/16/source/SRPMS
FEDORA=16

MY_P="${PN}-$(get_version_component_range 1-3)"

DESCRIPTION="Fedora official background artwork"
HOMEPAGE="https://fedoraproject.org/wiki/F16_Artwork"

SRC_URI="mirror://fedora-dev/${SRC_PATH}/${PN}-$(replace_version_separator 3 -).fc${FEDORA}.src.rpm"

LICENSE="CCPL-Attribution-ShareAlike-3.0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="!x11-themes/fedora-backgrounds:16"
DEPEND=""

S="${WORKDIR}/${MY_P}"

SLOT=0

src_unpack() {
	rpm_src_unpack

	# as of 2011-03-08 rpm.eclass does not unpack the further xz
	# file automatically.
	unpack ./${MY_P}.tar.xz
}

src_compile() { :; }
src_test() { :; }

src_install() {
	# The install targets are serial anyway.
	emake -j1 DESTDIR="${D}" install || die "emake install failed"

	dodoc Attribution
}
