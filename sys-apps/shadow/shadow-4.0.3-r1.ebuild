# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/shadow/shadow-4.0.3-r1.ebuild,v 1.1 2002/10/19 09:31:05 azarah Exp $

inherit libtool

S="${WORKDIR}/${P}"
HOMEPAGE="http://shadow.pld.org.pl/"
DESCRIPTION="Utilities to deal with user accounts"
SRC_URI="ftp://ftp.pld.org.pl/software/shadow/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~sparc64 ~alpha"

DEPEND=">=sys-libs/pam-0.75-r4
	>=sys-libs/cracklib-2.7-r3
	sys-devel/gettext"
	
RDEPEND=">=sys-libs/pam-0.75-r4
	>=sys-libs/cracklib-2.7-r3"


pkg_preinst() { 
	rm -f ${ROOT}/etc/pam.d/system-auth.new
}

src_unpack() {
	unpack ${A}

	# Get su to call pam_open_session(), and also set DISPLAY and XAUTHORITY,
	# else the session entries in /etc/pam.d/su never get executed, and
	# pam_xauth for one, is then never used.  This should close bug #8831.
	#
	# <azarah@gentoo.org> (19 Oct 2002)
	cd ${S}; patch -p1 < ${FILESDIR}/${P}-su-pam_open_session.patch || die
}

src_compile() {
	elibtoolize

	local myconf=""
	use nls || myconf="${myconf} --disable-nls"

	./configure --disable-desrpc \
		--with-libcrypt \
		--with-libcrack \
		--with-libpam \
		--enable-shared=no \
		--enable-static=yes \
		--host=${CHOST} \
		${myconf} || die "bad configure"
		
	# Parallel make fails sometimes
	make || die "compile problem"
}

src_install() {
	dodir /etc/default /etc/skel

	make prefix=${D}/usr \
		exec_prefix=${D} \
		mandir=${D}/usr/share/man \
		install || die "install problem"

	#do not install this login, but rather the one from
	#util-linux, as this one have a serious root exploit
	#with pam_limits in use.
	rm ${D}/bin/login

	mv ${D}/lib ${D}/usr
	dosed "s:/lib':/usr/lib':g" /usr/lib/libshadow.la
	dosed "s:/lib/:/usr/lib/:g" /usr/lib/libshadow.la
	dosed "s:/lib':/usr/lib':g" /usr/lib/libmisc.la
	dosed "s:/lib/:/usr/lib/:g" /usr/lib/libmisc.la
	dosym /usr/bin/newgrp /usr/bin/sg
	dosym /usr/sbin/useradd /usr/sbin/adduser
	dosym /usr/sbin/vipw /usr/sbin/vigr
	# remove dead links
	rm -f ${D}/bin/{sg,vipw}

	insinto /etc
	# Using a securetty with devfs device names added
	# (compat names kept for non-devfs compatibility)
	insopts -m0600 ; doins ${FILESDIR}/securetty
	insopts -m0600 ; doins ${S}/etc/login.access
	insopts -m0644 ; doins ${S}/etc/limits

	# needed for 'adduser -D'
	keepdir /etc/default

# From sys-apps/pam-login now
#	insopts -m0644 ; doins ${FILESDIR}/login.defs
	insinto /etc/pam.d ; insopts -m0644
	cd ${FILESDIR}/pam.d
	doins *
	newins system-auth system-auth.new
	newins shadow chage
	newins shadow chsh
	newins shadow chfn
	newins shadow useradd
	newins shadow groupadd
	cd ${S}

	# the manpage install is beyond my comprehension, and also broken.
	# just do it over.
	rm -rf ${D}/usr/share/man/*
	for q in man/*.[0-9]
	do
		local dir="${D}/usr/share/man/man${q##*.}"
		mkdir -p $dir
		cp $q $dir
	done
	
	#dont install the manpage, since we dont use
	#login with shadow
	rm ${D}/usr/share/man/man1/login.*
	
	cd ${S}/doc
	dodoc ANNOUNCE INSTALL LICENSE README WISHLIST
	docinto txt
	dodoc HOWTO LSM README.* *.txt

	# Fix sparc serial console
	if [ "${ARCH}" == "sparc" -o "${ARCH}" == "sparc64" ]; then
		cd ${D}/etc
		cp securetty securetty.orig
		# ttyS0 and its devfsd counterpart (Sparc serial port "A")
		sed -e 's:\(vc/1\)$:tts/0\n\1:' \
			-e 's:\(tty1\)$:ttyS0\n\1:' \
			securetty.orig > securetty || die
		rm securetty.orig
	fi
}

pkg_postinst() {
	echo
	echo "****************************************************"
	echo "   Due to a security issue, ${ROOT}etc/pam.d/system-auth "
	echo "   is being updated automatically. Your old "
	echo "   system-auth will be backed up as:"
	echo "   ${ROOT}etc/pam.d/system-auth.bak"
	echo "****************************************************"
	echo
	local CHECK1=`md5sum ${ROOT}/etc/pam.d/system-auth | cut -d ' ' -f 1`
	local CHECK2=`md5sum ${ROOT}/etc/pam.d/system-auth.new | cut -d ' ' -f 1`

	if [ "$CHECK1" != "$CHECK2" ];
	then
		cp -a ${ROOT}/etc/pam.d/system-auth \
	              ${ROOT}/etc/pam.d/system-auth.bak;
		mv -f ${ROOT}/etc/pam.d/system-auth.new \
	              ${ROOT}/etc/pam.d/system-auth
	else
		rm -f ${ROOT}/etc/pam.d/system-auth.new
	fi
}

