# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcube/wmcube-0.98.ebuild,v 1.2 2003/02/04 01:46:46 raker Exp $

DESCRIPTION="a dockapp cpu monitor with spinning 3d objects"
HOMEPAGE="http://kling.mine.nu/kling/wmcube.htm"
SRC_URI="http://kling.mine.nu/kling/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND="virtual/glibc
	virtual/x11"

S="${WORKDIR}/${P}/wmcube"

src_compile() {

	emake || die "parallel make failed"

}

src_install() {

  dobin wmcube

  cd ..
  dodoc README CHANGES

  SHARE=${DESTTREE}/share/wmcube
  dodir ${SHARE}
  insinto ${SHARE}
  doins 3dObjects/*

}

