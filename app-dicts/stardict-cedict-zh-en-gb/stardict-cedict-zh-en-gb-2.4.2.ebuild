# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict-cedict-zh-en-gb/stardict-cedict-zh-en-gb-2.4.2.ebuild,v 1.5 2004/06/29 20:30:22 agriffis Exp $

FROM_LANG="Simplified Chinese (GB)"
TO_LANG="English"
DICT_PREFIX="cedict-"
DICT_SUFFIX="gb"

inherit stardict

HOMEPAGE="http://stardict.sourceforge.net/Dictionaries_zh_CN.php"

KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND=">=app-dicts/stardict-2.4.2"
