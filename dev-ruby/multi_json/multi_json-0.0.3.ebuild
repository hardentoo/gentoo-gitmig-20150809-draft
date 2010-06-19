# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/multi_json/multi_json-0.0.3.ebuild,v 1.1 2010/06/19 11:35:43 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_TASK_TEST="spec"
RUBY_FAKEGEM_TASK_DOC="rdoc"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

inherit ruby-fakegem

DESCRIPTION="A gem to provide swappable JSON backends"
HOMEPAGE="http://github.com/intridea/multi_json"
LICENSE="MIT"

KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

ruby_add_rdepend "|| ( dev-ruby/json dev-ruby/yajl-ruby dev-ruby/activesupport )"

# I've switched one of the tests from requiring yajl to requiring
# json-pure since it's the only implementation that is available for
# all the Ruby interpreters we support.
ruby_add_bdepend "test? ( dev-ruby/rspec dev-ruby/json )"

RUBY_PATCHES=( "${FILESDIR}"/${P}-gentoo.patch )
