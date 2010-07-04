# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-inifile/ruby-inifile-2.0.0-r1.ebuild,v 1.1 2010/07/04 18:57:09 graaff Exp $

EAPI=2
USE_RUBY="ruby18"

inherit ruby-ng

DESCRIPTION="Small library to parse INI-files in Ruby"
HOMEPAGE="http://raa.ruby-lang.org/project/ruby-inifile/"
SRC_URI="http://gregoire.lejeune.free.fr/${PN}_${PV}.tar.gz"

SLOT="0"
IUSE=""
LICENSE="Ruby"
KEYWORDS="~x86 ~amd64"
S=${WORKDIR}/${PN}

each_ruby_test() {
	cd tests
	for test in *.rb ; do
		${RUBY} -I../lib $test || die
	done
}

each_ruby_install() {
	${RUBY} setup.rb config --prefix="${D}"/usr || die
	${RUBY} setup.rb install || die
}

all_ruby_install() {
	dodoc AUTHORS README || die
}
