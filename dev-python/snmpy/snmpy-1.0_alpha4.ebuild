# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/snmpy/snmpy-1.0_alpha4.ebuild,v 1.10 2002/12/15 10:44:19 bjb Exp $

TARNAME=snmpy-alpha-4
S=${WORKDIR}/${TARNAME}
DESCRIPTION="python SNMP interface"
SRC_URI="mirror://sourceforge/snmpy/${TARNAME}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/snmpy/"
LICENSE="CNRI"
SLOT="0"
KEYWORDS="x86 sparc alpha"

DEPEND="virtual/python
	>=net-analyzer/ucd-snmp-4.2.0"


mydocs="RELEASE-NOTES docs/docs.html"
inherit distutils
