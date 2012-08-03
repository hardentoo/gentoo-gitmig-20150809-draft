# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ragel/ragel-6.7-r1.ebuild,v 1.6 2012/08/03 20:28:15 blueness Exp $

EAPI=4

inherit eutils autotools

DESCRIPTION="Compiles finite state machines from regular languages into executable code."
HOMEPAGE="http://www.complang.org/ragel/"
SRC_URI="http://www.complang.org/ragel/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="vim-syntax"

DEPEND=""
RDEPEND=""

# We need to get the txl language in Portage to have the tests :(
RESTRICT=test

DOCS=( ChangeLog CREDITS README TODO )

src_prepare() {
	epatch "${FILESDIR}"/${P}+gcc-4.7.patch
	sed -i -e '/CXXFLAGS/d' configure.in || die

	eautoreconf
}

src_configure() {
	econf --docdir="${EPREFIX}"/usr/share/doc/${PF}
}

src_test() {
	cd "${S}"/test
	./runtests.in || die
}

src_install() {
	default

	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/syntax
		doins ragel.vim || die "doins ragel.vim failed"
	fi
}
