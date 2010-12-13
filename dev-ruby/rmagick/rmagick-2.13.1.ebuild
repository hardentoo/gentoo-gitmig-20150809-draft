# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rmagick/rmagick-2.13.1.ebuild,v 1.3 2010/12/13 16:01:53 graaff Exp $

EAPI="2"
USE_RUBY="ruby18 ree18 ruby19"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="ChangeLog README.html README-Mac-OSX.txt"

inherit multilib ruby-fakegem

DESCRIPTION="An interface between Ruby and the ImageMagick(TM) image processing library"
HOMEPAGE="http://rmagick.rubyforge.org/"
SRC_URI="mirror://rubyforge/rmagick/RMagick-${PV}.tar.bz2"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

# hdri causes extensive changes in the imagemagick internals, and
# rmagick is not ready to deal with those, see bug 184356.
RDEPEND=">=media-gfx/imagemagick-6.4.9[-hdri]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/RMagick-${PV}"

each_ruby_configure() {
	pushd ext/RMagick
	${RUBY} extconf.rb || die "extconf.rb failed"
	popd
}

each_ruby_compile() {
	pushd ext/RMagick
	emake || die "emake failed"
	popd
}

each_ruby_install() {
	each_fakegem_install
	ruby_fakegem_newins ext/RMagick/RMagick2$(get_modname) lib/RMagick2$(get_modname)
}

all_ruby_install() {
	all_fakegem_install

	docinto examples
	dodoc examples/* || die "failed to install examples"

	if use doc ; then
		dohtml -r doc || die "failed to install documentation"
	fi
}
