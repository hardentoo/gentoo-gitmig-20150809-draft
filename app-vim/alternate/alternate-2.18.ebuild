# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/alternate/alternate-2.18.ebuild,v 1.6 2010/10/10 06:58:19 phajdan.jr Exp $

inherit vim-plugin eutils

DESCRIPTION="vim plugin: quickly switch between .c and .h files"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=31"

LICENSE="as-is"
KEYWORDS="~alpha amd64 ~ia64 ~mips ppc ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin provides a new :A command which will switch between a .c
file and the associated .h file. There is also :AS to split windows and
:AV to split windows vertiically."

src_unpack() {
	unpack ${A}
	cd "${S}"
	# fix switching between .cc and .hh files, thanks ciaranm
	epatch "${FILESDIR}"/${P}-hh-cc-alternation.patch
}
