# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrtools/cdrtools-2.01.01_alpha50.ebuild,v 1.1 2008/09/27 23:57:25 loki_val Exp $

inherit multilib eutils toolchain-funcs flag-o-matic

DESCRIPTION="A set of tools for CD/DVD reading and recording, including cdrecord"
HOMEPAGE="http://cdrecord.berlios.de/"
SRC_URI="ftp://ftp.berlios.de/pub/cdrecord/alpha/${P/_alpha/a}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1 CDDL-Schily"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="unicode"

DEPEND="virtual/libc
	sys-apps/acl
	!app-cdr/dvdrtools
	!app-cdr/cdrkit"

PROVIDE="virtual/cdrtools"

S="${WORKDIR}/${PN}-2.01.01"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "/INSDIR/ s/lib/$(get_libdir)/" \
		$(grep -l -r '^INSDIR.\+lib\(/siconv\)\?$' .) \
		|| die "404 on multilib-sed"

	sed -i -e 's:opt/schily:usr:' \
		$(grep -l --include='*.1' --include='*.8' -r 'opt/schily' .) \
		$(grep -l --include='*.c' --include='*.h' -r 'opt/schily' .) \
		|| die "404 on opt-schily sed"

	rm -f $(find . -name '*_p.mk')

	epatch "${FILESDIR}"/${PN}-2.01.01a03-warnings.patch
	epatch "${FILESDIR}"/${PN}-2.01.01_alpha50-asneeded.patch

	cd "${S}"/DEFAULTS
	local MYARCH="linux"

	sed -i "s:/opt/schily:/usr:g" Defaults.${MYARCH}
	sed -i "s:/usr/src/linux/include::g" Defaults.${MYARCH}

	# For dynamic linking:
	sed -i "s:static:dynamic:" Defaults.${MYARCH}

	# lame symlinks that all point to the same thing
	cd "${S}"/RULES
	local t
	for t in ppc64 sh4 s390x ; do
		ln -s i586-linux-cc.rul ${t}-linux-cc.rul || die
		ln -s i586-linux-gcc.rul ${t}-linux-gcc.rul || die
	done

}

src_compile() {
	if use unicode; then
		local flags="$(test-flags -finput-charset=ISO-8859-1 -fexec-charset=UTF-8)"
		if [[ -n ${flags} ]]; then
			append-flags ${flags}
		else
			ewarn "Your compiler does not support the options required to build"
			ewarn "cdrtools with unicode in USE. unicode flag will be ignored."
		fi
	fi
	emake CC="$(tc-getCC) -D__attribute_const__=const" COPTX="${CFLAGS}" CPPOPTX="${CPPFLAGS}" LDOPTX="${LDFLAGS}" || die
}

src_install() {
	emake INS_BASE="${D}/usr/" install
	#These symlinks are for compat with cdrkit.
	dosym schily /usr/include/scsilib
	dosym ../../scg /usr/include/schily/scg
}

pkg_postinst() {
	echo
	einfo "The command line option 'dev=/dev/hdX' (X is the name of your drive)"
	einfo "should be used for IDE CD writers.  And make sure that the permissions"
	einfo "on this device are set properly and your user is in the correct group."
}
