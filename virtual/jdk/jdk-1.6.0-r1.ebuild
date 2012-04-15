# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/jdk/jdk-1.6.0-r1.ebuild,v 1.2 2012/04/15 18:27:18 vapier Exp $

EAPI="4"

DESCRIPTION="Virtual for JDK"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="1.6"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86 ~ppc-aix ~x86-fbsd ~x64-freebsd ~hppa-hpux ~ia64-hpux ~amd64-linux ~x86-linux ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris ~x86-winnt"
IUSE=""

# The keyword voodoo below is needed to work around confilcting masking types
# and for having arch specific preferences.
# All VMs must be listed in the no use flag enabled case which reflects the
# default order for amd64 and x86.

# This is that ppc(64) users will get a masked license warning for ibm-jdk-bin
# instead of (not useful) missing keyword warning for sun-jdk. #287615
PPC_OPTS="|| (
	=dev-java/ibm-jdk-bin-1.6.0*
	=dev-java/icedtea-6* )"

# Prefix defaults - prefer sun-jdk over icedtea
PREFIX_OPTS="|| (
	=dev-java/icedtea-bin-6*
	=dev-java/icedtea-bin-1*
	=dev-java/sun-jdk-1.6.0* )"

# icedtea-bin-1* is old versioning scheme of icedtea-bin-6*
RDEPEND="|| (
	ppc? ( ${PPC_OPTS} )
	ppc64? ( ${PPC_OPTS} )
	prefix? ( ${PREFIX_OPTS} )
	=dev-java/icedtea-bin-6*
	=dev-java/icedtea-bin-1*
	=dev-java/icedtea-6*
	=dev-java/sun-jdk-1.6.0*
	=dev-java/ibm-jdk-bin-1.6.0*
	=dev-java/hp-jdk-bin-1.6.0*
	=dev-java/diablo-jdk-1.6.0*
	=dev-java/soylatte-jdk-bin-1.0*
	=dev-java/apple-jdk-bin-1.6.0*
	=dev-java/winjdk-bin-1.6.0* )"
