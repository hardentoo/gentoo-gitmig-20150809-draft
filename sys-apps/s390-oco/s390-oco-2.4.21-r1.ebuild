# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/s390-oco/s390-oco-2.4.21-r1.ebuild,v 1.3 2005/07/12 01:38:16 vapier Exp $

DESCRIPTION="Object-code only (OCO) modules for s390"
HOMEPAGE="http://oss.software.ibm.com/developerworks/opensource/linux390/june2003_recommended.shtml"
if [[ ${CTARGET:-${CHOST}} == s390x-* ]] ; then
SRC_URI="tape3590-2.4.21-s390x-02-june2003.tar.gz"
else
SRC_URI="tape3590-2.4.21-s390-02-june2003.tar.gz"
fi

LICENSE="IBM-ILNWP"
SLOT="${KV}"
KEYWORDS="~s390"
IUSE=""
RESTRICT="fetch"

DEPEND="~sys-kernel/vanilla-sources-2.4.21"

pkg_nofetch() {
	einfo "Please download ${A} from"
	einfo ""
	einfo " o ${HOMEPAGE}"
	einfo ""
	einfo "and put it into ${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	check_KV || die "Cannot find kernel in /usr/src/linux"
}

src_compile() {
	cd ${WORKDIR}
	mv tape3590-2.4.21-s390*-02-june2003.o tape_3590.o
}

src_install() {
	dodir /etc/modules.d
	insinto /etc/modules.d
	doins ${FILESDIR}/s390-oco

	cd ${WORKDIR}
	dodir /lib/modules/${KV}/OCO
	insinto /lib/modules/${KV}/OCO
	doins tape_3590.o

	dodoc README LICENSE
}
