# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict-quick-jpn-eng/stardict-quick-jpn-eng-2.4.2.ebuild,v 1.3 2004/06/24 21:49:14 agriffis Exp $

FROM_LANG="Japanese Romaji"
TO_LANG="English"
DICT_PREFIX="quick_"

inherit stardict

HOMEPAGE="http://stardict.sourceforge.net/Dictionaries_Quick.php"

KEYWORDS="~x86 ~ppc"

RDEPEND=">=app-dicts/stardict-2.4.2"
