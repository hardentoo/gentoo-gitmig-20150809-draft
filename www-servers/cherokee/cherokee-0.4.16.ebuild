# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/cherokee/cherokee-0.4.16.ebuild,v 1.2 2004/09/03 15:58:51 pvdabeel Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="An extremely fast and tiny web server."
SRC_URI="ftp://laurel.datsi.fi.upm.es/pub/linux/cherokee/0.4/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.alobbs.com/cherokee"
LICENSE="GPL-2"

DEPEND=">=sys-devel/automake-1.7.5
	${RDEPEND}"

RDEPEND="virtual/libc
	>=sys-libs/zlib-1.1.4-r1"

KEYWORDS="~x86 ppc"
SLOT="0"

src_unpack ()
{
	unpack "${A}"

}

src_compile ()
{

# coming soon ;-)
#	use php && my_conf="$my_conf --with-php"
#	use mono && my_conf="$my_conf --with-mono"

	./configure --prefix=/usr --sysconfdir=/etc --disable-static $my_conf --with-pic
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog COPYING INSTALL README

	# install the Gentoo-ised config file

#	cp ${FILESDIR}/${P}-cherokee.conf ${D}/etc/cherokee/cherokee.conf

	# remove the installed sample config file
#	rm ${D}/etc/cherokee/cherokee.conf.sample

	# add default doc-root and cgi-bin locations
	dodir /var/www/localhost/htdocs
	dodir /var/www/localhost/cgi-bin

	# add init.d script

	dodir /etc/init.d
	cp ${FILESDIR}/cherokee-0.4.5-init.d ${D}/etc/init.d/cherokee
}
