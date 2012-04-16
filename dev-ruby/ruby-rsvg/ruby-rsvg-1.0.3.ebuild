# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-rsvg/ruby-rsvg-1.0.3.ebuild,v 1.4 2012/04/16 20:04:23 ago Exp $

EAPI="2"
USE_RUBY="ruby18"

RUBY_FAKEGEM_NAME=rsvg2

inherit ruby-ng-gnome2

S=${WORKDIR}/ruby-gnome2-all-${PV}/rsvg2

DESCRIPTION="Ruby bindings for librsvg"
KEYWORDS="amd64 ~ppc ~x86"
IUSE="cairo"

RDEPEND="${RDEPEND}
	>=gnome-base/librsvg-2.8"
DEPEND="${DEPEND}
	>=gnome-base/librsvg-2.8
	dev-util/pkgconfig"

ruby_add_rdepend ">=dev-ruby/ruby-glib2-${PV}
	>=dev-ruby/ruby-gdkpixbuf2-${PV}
	cairo? ( dev-ruby/rcairo )"
