# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/epic4/epic4-1.1.14.ebuild,v 1.7 2004/07/09 22:53:51 swegener Exp $

inherit flag-o-matic

DESCRIPTION="Epic4 IRC Client"
HOMEPAGE="http://epicsol.org/"
SRC_URI="ftp://prbh.org/pub/epic/EPIC4-ALPHA/${P}.tar.bz2
	 ftp://prbh.org/pub/epic/EPIC4-PRODUCTION/epic4-help-20030114.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc ia64 ~alpha ~hppa"
IUSE="ipv6 perl ssl tcltk"

DEPEND=">=sys-libs/ncurses-5.2
	perl? ( >=dev-lang/perl-5.6.1 )
	ssl? ( >=dev-libs/openssl-0.9.5 )
	tcltk? ( dev-lang/tcl )"

src_compile() {
	replace-flags "-O?" "-O"

	myconf=""

	use ipv6 \
		&& myconf="${myconf} --with-ipv6" \
		|| myconf="${myconf} --without-ipv6"

	use perl \
		&& myconf="${myconf} --with-perl" \
		|| myconf="${myconf} --without-perl"

	use ssl \
		&& myconf="${myconf} --with-ssl" \
		|| myconf="${myconf} --without-ssl"

	use tcltk \
		&& myconf="${myconf} --with-tcl" \
		|| myconf="${myconf} --without-tcl"

	econf \
		--libexecdir=/usr/lib/misc \
		${myconf} || die "econf failed"

	make || die "make failed"
}

src_install () {
	einstall \
		sharedir=${D}/usr/share \
		libexecdir=${D}/usr/lib/misc || die "einstall failed"

	rm -f ${D}/usr/bin/epic
	dosym epic-EPIC4-${PV} /usr/bin/epic

	dodoc BUG_FORM COPYRIGHT README KNOWNBUGS VOTES
	docinto doc
	cd doc
	dodoc *.txt colors EPIC* IRCII_VERSIONS local_vars missing new-load
	dodoc nicknames outputhelp server_groups SILLINESS TS4

	dodir /usr/share/epic
	tar zxvf ${DISTDIR}/epic4-help-20030114.tar.gz -C ${D}/usr/share/epic
}

pkg_postinst() {
	einfo "If /usr/share/epic/script/local does not exist, I will now"
	einfo "create it.  If you do not like the look/feel of this file, or"
	einfo "if you'd prefer to use your own script, simply remove this"
	einfo "file.  If you want to prevent this file from being installed"
	einfo "in the future, simply create an empty file with this name."

	if [ ! -f ${ROOT}/usr/share/epic/script/local ]; then
		cp ${FILESDIR}/local ${ROOT}/usr/share/epic/script/
	fi
}
