# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Author: Seemant Kulleen <seemant@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/perl-module.eclass,v 1.17 2002/08/05 20:53:56 mcummings Exp $
# The perl-module eclass is designed to allow easier installation of perl
# modules, and their incorporation into the Gentoo Linux system.

#first inherit the pkg_postinst() and pkg_postrm() functions
inherit perl-post

ECLASS=perl-module
INHERITED="$INHERITED $ECLASS"

EXPORT_FUNCTIONS src_compile src_install src_test

newdepend ">=sys-devel/perl-5"

SRC_PREP="no"

perl-module_src_prep() {

	SRC_PREP="yes"
	perl Makefile.PL ${myconf} \
		PREFIX=${D}/usr 
}

perl-module_src_compile() {

	[ "${SRC_PREP}" != "yes" ] && perl-module_src_prep
	make ${mymake} || die "compilation failed"
}

perl-module_src_test() {
	make test
}

perl-module_src_install() {
	
	perl-post_perlinfo
	dodir ${POD_DIR}
	
	test -z ${mytargets} && mytargets="install"
	
	make \
		PREFIX=${D}/usr \
		INSTALLMAN1DIR=${D}/usr/share/man/man1 \
		INSTALLMAN2DIR=${D}/usr/share/man/man2 \
		INSTALLMAN3DIR=${D}/usr/share/man/man3 \
		INSTALLMAN4DIR=${D}/usr/share/man/man4 \
		INSTALLMAN5DIR=${D}/usr/share/man/man5 \
		INSTALLMAN6DIR=${D}/usr/share/man/man6 \
		INSTALLMAN7DIR=${D}/usr/share/man/man7 \
		INSTALLMAN8DIR=${D}/usr/share/man/man8 \
		${myinst} \
		${mytargets} || die

	sed -e "s:${D}::g" \
		${D}/${ARCH_LIB}/perllocal.pod \
			> ${D}/${POD_DIR}/${P}.pod
	
	rm -f ${D}/${ARCH_LIB}/perllocal.pod

	dodoc Change* MANIFEST* README* ${mydoc}
}
