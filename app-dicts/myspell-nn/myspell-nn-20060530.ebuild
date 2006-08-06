# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-nn/myspell-nn-20060530.ebuild,v 1.1 2006/08/06 18:46:18 kevquinn Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"nn,NO,nn_NO,Norwegian nynorsk (Norway),nn_NO.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"nn,NO,hyph_nn_NO,Norwegian nynorsk (Norway),hyph_nn_NO.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
"nn,NO,th_nn_NO_v1,Norwegian nynorsk (Norway),th_nn_NO_v1.zip"
)

inherit myspell

DESCRIPTION="Norwegian dictionaries for myspell/hunspell"
LICENSE="GPL-2"
HOMEPAGE="http://spell-norwegian.alioth.debian.org/"

KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
