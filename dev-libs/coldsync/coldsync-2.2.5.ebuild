# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author: Dimitri Aivaliotis <dimitri@aivaliotis.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/coldsync/coldsync-2.2.5.ebuild,v 1.1 2002/05/27 23:16:04 rphillips Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A command-line tool to synchronize PalmOS PDAs with Unix workstations"
SRC_URI="http://www.coldsync.org/download/${P}.tar.gz"
HOMEPAGE="http://www.coldsync.org/"
LICENSE="Artistic"

src_compile() {
	local myconf
	use nls || myconf="${myconf} --without-i18n"
	use perl || myconf="${myconf} --without-perl"

	econf ${myconf} || die "configuring coldsync failed"
	make || die "couldn't make coldsync"
}

src_install() {
	make \
		PREFIX=${D}/usr \
		MANDIR=${D}/usr/share/man \
		SYSCONFDIR=${D}/etc \
		DATADIR=${D}/usr/share \
		INFODIR=${D}/usr/share/info \
		install || die "couldn't install coldsync"

	dodoc AUTHORS Artistic ChangeLog HACKING INSTALL NEWS README TODO
}
