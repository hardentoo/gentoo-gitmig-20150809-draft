# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocaml-make/ocaml-make-5.04.0.ebuild,v 1.5 2004/07/14 01:40:17 lv Exp $

DESCRIPTION="Generic O'Caml Makefile for GNU Make"
HOMEPAGE="http://www.ai.univie.ac.at/~markus/home/ocaml_sources.html"
LICENSE="LGPL-2.1"

DEPEND=">=dev-lang/ocaml-3.06-r1
	>=dev-ml/findlib-0.8"
SRC_URI="http://www.oefai.at/~markus/ocaml_sources/${P}.tar.bz2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64"
IUSE=""

src_compile() {
	# Nothing to do
	echo -n
}

src_install () {
	# Just put the OCamlMakefile into /usr/include
	# where GNU Make will automatically pick it up.
	insinto /usr/include
	doins OCamlMakefile
	# install documentation
	dodoc LICENSE README Changes
}
