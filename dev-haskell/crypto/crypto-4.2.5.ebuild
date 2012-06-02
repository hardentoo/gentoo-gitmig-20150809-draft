# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/crypto/crypto-4.2.5.ebuild,v 1.1 2012/06/02 06:34:53 gienah Exp $

EAPI=4

# ebuild generated by hackport 0.2.18.9999

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit haskell-cabal

MY_PN="Crypto"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Collects together existing Haskell cryptographic functions into a package"
HOMEPAGE="http://hackage.haskell.org/package/Crypto"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/hunit[profile?]
		>=dev-haskell/quickcheck-2.4.0.1[profile?]
		dev-haskell/random[profile?]
		>=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2"

S="${WORKDIR}/${MY_P}"

src_test() {
	TESTS="SymmetricTest SHA1Test RSATest QuickTest HMACTest WordListTest"

	for t in $TESTS; do
		einfo "Running test $t..."
		# the quickcheck tests doesn't fail when the test fails...
		"${S}/dist/build/$t/$t" || die "Test $t failed"
	done
}

src_install() {
	cabal_src_install

	rm -rf "${D}/usr/bin" 2>/dev/null
}
