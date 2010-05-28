# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-syck/pecl-syck-0.9.2.ebuild,v 1.9 2010/05/28 22:01:50 mabi Exp $

PHP_EXT_NAME="syck"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="CHANGELOG TODO"

inherit php-ext-pecl-r1 depend.php

KEYWORDS="amd64 ~arm ppc ppc64 x86"

DESCRIPTION="PHP bindings for Syck - reads and writes YAML with it."
LICENSE="PHP-3.01"
SLOT="0"
IUSE=""

DEPEND="dev-libs/syck"
RDEPEND="${DEPEND}"

need_php_by_category

pkg_setup() {
	require_php_with_use spl hash
}
