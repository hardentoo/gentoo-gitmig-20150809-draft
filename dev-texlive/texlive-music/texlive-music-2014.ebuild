# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-music/texlive-music-2014.ebuild,v 1.4 2015/07/22 19:37:40 blueness Exp $

EAPI="5"

TEXLIVE_MODULE_CONTENTS="abc figbas gchords gtrcrd guitar guitarchordschemes harmony lilyglyphs m-tx musixguit musixtex musixtex-fonts pmx pmxchords songbook songs collection-music
"
TEXLIVE_MODULE_DOC_CONTENTS="abc.doc figbas.doc gchords.doc gtrcrd.doc guitar.doc guitarchordschemes.doc harmony.doc lilyglyphs.doc m-tx.doc musixguit.doc musixtex.doc musixtex-fonts.doc pmx.doc pmxchords.doc songbook.doc songs.doc "
TEXLIVE_MODULE_SRC_CONTENTS="abc.source guitar.source lilyglyphs.source musixtex.source songbook.source songs.source "
inherit  texlive-module
DESCRIPTION="TeXLive Music packages"

LICENSE=" GPL-1 GPL-2 LGPL-2.1 LPPL-1.2 LPPL-1.3 "
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~mips ppc ~ppc64 ~s390 ~sh x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-latex-2014
!<app-text/texlive-core-2011
"
RDEPEND="${DEPEND} "
TEXLIVE_MODULE_BINSCRIPTS="
	texmf-dist/scripts/musixtex/musixflx.lua
	texmf-dist/scripts/musixtex/musixtex.lua
	texmf-dist/scripts/m-tx/m-tx.lua
	texmf-dist/scripts/pmx/pmx2pdf.lua
	texmf-dist/scripts/pmxchords/pmxchords.lua
	texmf-dist/scripts/lilyglyphs/lily-glyph-commands.py
	texmf-dist/scripts/lilyglyphs/lily-image-commands.py
	texmf-dist/scripts/lilyglyphs/lily-rebuild-pdfs.py
"
