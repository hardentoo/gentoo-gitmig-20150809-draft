# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-xml-dtd/docbook-xml-dtd-4.1.2-r4.ebuild,v 1.7 2004/04/26 11:30:52 obz Exp $

MY_P="docbkx412"
DESCRIPTION="Docbook DTD for XML"
SRC_URI="http://www.oasis-open.org/docbook/xml/${PV}/${MY_P}.zip"
HOMEPAGE="http://www.oasis-open.org/docbook/"
LICENSE="X11"

SLOT="4.1.2"
IUSE=""
KEYWORDS="ia64 x86 ppc sparc alpha hppa amd64 mips"

DEPEND=">=app-arch/unzip-5.41
	>=dev-libs/libxml2-2.4
	>=app-text/docbook-xsl-stylesheets-1.45"

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${A}
}

src_install() {

	# still use the -r3 build file
	newbin ${FILESDIR}/build-docbook-catalog-${PV}-r3 build-docbook-catalog

	keepdir /etc/xml

	insinto /usr/share/sgml/docbook/xml-dtd-${PV}
	doins *.dtd *.mod
	doins docbook.cat
	insinto /usr/share/sgml/docbook/xml-dtd-${PV}/ent
	doins ent/*.ent

	dodoc ChangeLog *.txt
}

pkg_postinst() {
	build-docbook-catalog

	# we need to add the docbookx.dtd to local, so
	# packages that refer to it dont need to go http
	# for it <obz@gentoo.org>
	CATALOG=/etc/xml/catalog

	/usr/bin/xmlcatalog --noout --add "rewriteSystem" \
		"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" \
		"/usr/share/sgml/docbook/xml-dtd-4.1.2/docbookx.dtd" \
		${CATALOG}

	/usr/bin/xmlcatalog --noout --add "rewriteURI" \
		"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" \
		"/usr/share/sgml/docbook/xml-dtd-4.1.2/docbookx.dtd" \
		${CATALOG}

}

pkg_postrm( ) {

	# and clean up the docbookx.dtd once we've been removed
	CATALOG=/etc/xml/catalog
	/usr/bin/xmlcatalog --noout --del \
		"/usr/share/sgml/docbook/xml-dtd-4.1.2/docbookx.dtd" \
		${CATALOG}

}
