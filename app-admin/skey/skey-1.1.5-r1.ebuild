# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/skey/skey-1.1.5-r1.ebuild,v 1.1 2003/11/05 16:03:00 taviso Exp $

inherit flag-o-matic ccc eutils

DESCRIPTION="Linux Port of OpenBSD Single-key Password System"
HOMEPAGE="http://www.sparc.spb.su/solaris/skey/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
		doc? ( http://www.ietf.org/rfc/rfc2289.txt )"

LICENSE="BSD X11"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm ~amd64"

IUSE="doc"
RDEPEND=">=dev-lang/perl-5.8.0
		virtual/mta
		net-mail/mailx
		virtual/glibc"
DEPEND=">=dev-lang/perl-5.8.0
	virtual/mta
	virtual/glibc"

S=${WORKDIR}/${P}

src_unpack() {

	# ive ported some updates to this s/key implementation from NetBSD to Linux. 
	# some other changes i've made include
	# 	- replaced many of the uses of strcat/strcpy to strncat/strncpy.
	# 	- removed a lot of multi-line string literals in preparation of gcc3.3.
	# 	- removed some of the crazier syntax, like casting all function calls to
	#		void, whats up with that? :)
	#	- killing rmd160 support
	#	- removed skeyaudit and replaced it with a simple shell script 
	#	- providing a shared library, so dynamic linking should be possible.
	#	- using manpages from NetBSD, which are of better quality.
	#	- be a little bit more reasonable about password security..do we really have
	#		to force people to have digits in there?
	#	- some other misc. stuff.
	# (05 Nov 2003) -taviso@gentoo.org
	unpack ${A}
	cd ${S}; epatch ${FILESDIR}/skey-1.1.5-gentoo.diff.gz
}

src_compile() {

	if use alpha; then
		append-flags -fPIC
		append-ldflags -fPIC
	fi

	# skeyprune wont honour @sysconfdir@
	sed -i 's#/etc/skeykeys#/etc/skey/skeyskeys#g' skeyprune.pl skeyprune.8

	econf --sysconfdir=/etc/skey || die
	emake || die
}

src_install() {
	doman skey.1 skeyaudit.1 skeyinfo.1 skeyinit.1 skeyprune.8
	dobin skey skeyinit skeyinfo
	newbin skeyprune.pl skeyprune
	newbin skeyaudit.sh skeyaudit
	dolib.a libskey.a
	dolib.so libskey.so.1.1.5 libskey.so.1.1 libskey.so.1 libskey.so

	insinto /usr/include
	doins skey.h

	insinto /etc/skey
	newins /dev/null skeykeys

	# only root needs to have access to these files.
	fperms g-rx,o-rx /etc/skey/skeykeys /etc/skey

	# skeyinit and skeyinfo must be suid root so users
	# can generate their passwords.
	#
	# probably a good idea to remove read permission to
	# suid binaries.
	fperms u+s,o-r,g-r /usr/bin/skeyinit /usr/bin/skeyinfo

	dodoc README CHANGES md4.copyright md5.copyright
	use doc && dodoc ${DISTDIR}/rfc2289.txt

	prepallman
}

pkg_postinst()
{
	einfo "For an instroduction into using s/key authentication, take"
	einfo "a look at the EXAMPLES section from the skey(1) manpage."
	einfo
	einfo "This version of skey contains numerous updates, and is not totally"
	einfo "syntax or source compatible with the previous version."
	einfo "Please report any issues with skey using http://bugs.gentoo.org/"
}

