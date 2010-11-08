# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libglade/libglade-2.6.4.ebuild,v 1.8 2010/11/08 22:43:29 eva Exp $

EAPI="2"
PYTHON_DEPEND="2"

inherit eutils gnome2 python

DESCRIPTION="Library to construct graphical interfaces at runtime"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="2.0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2.10:2
	>=x11-libs/gtk+-2.8.10:2
	>=dev-libs/atk-1.9
	>=dev-libs/libxml2-2.4.10"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	doc? ( >=dev-util/gtk-doc-1 )"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	python_set_active_version 2
}

src_prepare() {
	# patch to stop make install installing the xml catalog
	# because we do it ourselves in postinst()
	epatch "${FILESDIR}"/Makefile.in.am-2.4.2-xmlcatalog.patch

	# patch to not throw a warning with gtk+-2.14 during tests, as it triggers abort
	epatch "${FILESDIR}/${PN}-2.6.3-fix_tests-page_size.patch"
}

src_install() {
	dodir /etc/xml
	gnome2_src_install
	python_convert_shebangs 2 "${D}"/usr/bin/libglade-convert
}

pkg_postinst() {
	echo ">>> Updating XML catalog"
	/usr/bin/xmlcatalog --noout --add "system" \
		"http://glade.gnome.org/glade-2.0.dtd" \
		/usr/share/xml/libglade/glade-2.0.dtd /etc/xml/catalog
	gnome2_pkg_postinst
}

pkg_postrm() {
	gnome2_pkg_postrm
	echo ">>> removing entries from the XML catalog"
	/usr/bin/xmlcatalog --noout --del \
		/usr/share/xml/libglade/glade-2.0.dtd /etc/xml/catalog
}
