# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/doxygen/doxygen-1.4.4.ebuild,v 1.19 2006/06/24 01:44:20 cardoe Exp $

inherit eutils toolchain-funcs qt3

DESCRIPTION="Documentation and analysis tool for C++, C, Java, IDL, PHP and C#"
HOMEPAGE="http://www.doxygen.org/"
SRC_URI="ftp://ftp.stack.nl/pub/users/dimitri/${P}.src.tar.gz
		unicode? ( mirror://gentoo/${PN}-utf8-ru.patch.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ~ppc-macos ppc64 s390 sh sparc x86"
IUSE="doc qt3 tetex unicode"

RDEPEND="media-gfx/graphviz
	qt3? ( $(qt_min_version 3.3) )
	tetex? ( virtual/tetex )
	virtual/ghostscript"
DEPEND=">=sys-apps/sed-4
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# use CFLAGS and CXXFLAGS (on linux and ppc-macos)
	sed -i.orig -e "s:^\(TMAKE_CFLAGS_RELEASE\t*\)= .*$:\1= ${CFLAGS}:" \
		-e "s:^\(TMAKE_CXXFLAGS_RELEASE\t*\)= .*$:\1= ${CXXFLAGS}:" \
		tmake/lib/{linux-g++,macosx-c++}/tmake.conf

	epatch "${FILESDIR}"/doxygen-1.4.3-cp1251.patch
	epatch "${FILESDIR}"/${P}-darwin.patch

	if use unicode; then
		epatch "${WORKDIR}"/${PN}-utf8-ru.patch || die "utf8-ru patch failed"
	fi

	if [ $(gcc-major-version) -eq 4 ] ; then
		epatch "${FILESDIR}"/${PN}-gcc4.patch || die "gcc4 patch failed"
	fi
}

src_compile() {
	# set ./configure options (prefix, Qt based wizard, docdir)
	local my_conf="--prefix ${D}usr"
	if use qt3; then
	    einfo "using QTDIR: '$QTDIR'."
	    export LD_LIBRARY_PATH=${QTDIR}/$(get_libdir):${LD_LIBRARY_PATH}
	    export LIBRARY_PATH=${QTDIR}/$(get_libdir):${LIBRARY_PATH}
	    einfo "using QT LIBRARY_PATH: '$LIBRARY_PATH'."
	    einfo "using QT LD_LIBRARY_PATH: '$LD_LIBRARY_PATH'."
	    ./configure ${my_conf} $(use_with qt3 doxywizard) || die 'configure failed'
	else
	    ./configure ${my_conf} || die 'configure failed'
	fi

	# and compile
	emake all || die 'emake failed'

	# generate html and pdf (if tetex in use) documents.
	# errors here are not considered fatal, hence the ewarn message
	# TeX's font caching in /var/cache/fonts causes sandbox warnings,
	# so we allow it.
	if use doc; then
		if use tetex; then
			addwrite /var/cache/fonts
			addwrite /usr/share/texmf/fonts/pk
			addwrite /usr/share/texmf/ls-R
			make pdf || ewarn '"make docs" failed.'
		else
			cp doc/Doxyfile doc/Doxyfile.orig
			cp doc/Makefile doc/Makefile.orig
			sed -i.orig -e "s/GENERATE_LATEX    = YES/GENERATE_LATEX    = NO/" doc/Doxyfile
			sed -i.orig -e "s/@epstopdf/# @epstopdf/" \
				-e "s/@cp Makefile.latex/# @cp Makefile.latex/" \
				-e "s/@sed/# @sed/" doc/Makefile
			make docs || ewarn '"make docs" failed.'
		fi
	fi
}

src_install() {
	make DESTDIR="${D}" MAN1DIR=share/man/man1 \
		install || die '"make install" failed.'

	dodoc INSTALL LANGUAGE.HOWTO README VERSION

	# pdf and html manuals
	if use doc; then
		insinto /usr/share/doc/${PF}
		if use tetex; then
			doins latex/doxygen_manual.pdf
		fi
		dohtml -r html/*
	fi
}

pkg_postinst() {

	ewarn
	einfo "The USE flags qt3, doc, and tetex will enable doxywizard, or"
	einfo "the html and pdf documentation, respectively.  For examples"
	einfo "and other goodies, see the source tarball.  For some example"
	einfo "output, run doxygen on the doxygen source using the Doxyfile"
	einfo "provided in the top-level source dir."
	ewarn
}
