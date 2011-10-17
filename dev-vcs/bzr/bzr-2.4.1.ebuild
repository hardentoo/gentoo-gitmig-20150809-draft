# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/bzr/bzr-2.4.1.ebuild,v 1.4 2011/10/17 20:34:32 maekke Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45] 3.*"

inherit bash-completion distutils elisp-common eutils versionator

MY_P=${PN}-${PV}
SERIES=$(get_version_component_range 1-2)

DESCRIPTION="Bazaar is a next generation distributed version control system."
HOMEPAGE="http://bazaar-vcs.org/"
#SRC_URI="http://bazaar-vcs.org/releases/src/${MY_P}.tar.gz"
SRC_URI="http://launchpad.net/bzr/${SERIES}/${PV}/+download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris"
IUSE="curl doc emacs +sftp test"

RDEPEND="|| ( dev-lang/python:2.7[xml] dev-lang/python:2.6[xml] dev-python/celementtree )
	curl? ( dev-python/pycurl )
	sftp? ( dev-python/paramiko )"

DEPEND="emacs? ( virtual/emacs )
	test? (
		${RDEPEND}
		|| ( dev-python/pyftpdlib dev-python/medusa )
		dev-python/subunit
		>=dev-python/testtools-0.9.5
	)"

S="${WORKDIR}/${MY_P}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS="doc/*.txt"
PYTHON_MODNAME="bzrlib"
SITEFILE="71bzr-gentoo.el"

src_prepare() {
	distutils_src_prepare

	# Don't regenerate .c files from .pyx when pyrex is found.
	epatch "${FILESDIR}/${PN}-2.4.0-no-pyrex-citon.patch"
}

src_compile() {
	distutils_src_compile

	if use emacs; then
		elisp-compile contrib/emacs/bzr-mode.el || die
	fi
}

src_test() {
	# Some tests expect the usual pyc compiling behaviour.
	python_enable_pyc

	# Define tests which are known to fail below.
	local skip_tests="("
	# https://bugs.launchpad.net/bzr/+bug/850676
	skip_tests+="per_transport.TransportTests.test_unicode_paths.*|"
	# libcurl cannot verify SSL certs
	# https://bugs.launchpad.net/bzr/+bug/82086
	skip_tests+="per_transport.TransportTests.test_clone|per_transport.TransportTests.test_connection_sharing|per_transport.TransportTests.test_copy_to|per_transport.TransportTests.test_get|per_transport.TransportTests.test_get_bytes|per_transport.TransportTests.test_get_bytes_unknown_file|per_transport.TransportTests.test_get_directory_read_gives_ReadError|per_transport.TransportTests.test_get_unknown_file|per_transport.TransportTests.test_has|per_transport.TransportTests.test_has_root_works|per_transport.TransportTests.test_readv|per_transport.TransportTests.test_readv_out_of_order|per_transport.TransportTests.test_readv_short_read|per_transport.TransportTests.test_readv_with_adjust_for_latency|per_transport.TransportTests.test_readv_with_adjust_for_latency_with_big_file|per_transport.TransportTests.test_reuse_connection_for_various_paths|test_read_bundle.TestReadMergeableBundleFromURL.test_read_mergeable_respects_possible_transports|test_read_bundle.TestReadMergeableBundleFromURL.test_read_mergeable_from_url|test_read_bundle.TestReadMergeableBundleFromURL.test_read_fail|test_http.TestActivity.test_readv|test_http.TestActivity.test_post|test_http.TestActivity.test_has|test_http.TestActivity.test_get"
	skip_tests+=")"
	if [[ -n ${skip_tests} ]]; then
		einfo "Skipping tests known to fail: ${skip_tests}"
	fi

	testing() {
		LC_ALL="C" "$(PYTHON)" bzr --no-plugins selftest ${skip_tests:+-x} ${skip_tests}
	}
	python_execute_function testing

	# Just to make sure we don't hit any errors on later stages.
	python_disable_pyc
}

src_install() {
	distutils_src_install --install-data "${EPREFIX}/usr/share"

	if use doc; then
		docinto developers
		dodoc doc/developers/* || die
		for doc in mini-tutorial tutorials user-{guide,reference}; do
			docinto $doc
			dodoc doc/en/$doc/* || die
		done
	fi

	if use emacs; then
		elisp-install ${PN} contrib/emacs/*.el* || die
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die

		# don't add automatically to the load-path, so the sitefile
		# can do a conditional loading
		touch "${ED}${SITELISP}/${PN}/.nosearch"
	fi

	dobashcompletion contrib/bash/bzr
}

pkg_postinst() {
	distutils_pkg_postinst
	bash-completion_pkg_postinst

	if use emacs; then
		elisp-site-regen
		elog "If you are using a GNU Emacs version greater than 22.1, bzr support"
		elog "is already included.  This ebuild does not automatically activate bzr support"
		elog "in versions below, but prepares it in a way you can load it from your ~/.emacs"
		elog "file by adding"
		elog "       (load \"bzr-mode\")"
	fi
}

pkg_postrm() {
	distutils_pkg_postrm
	use emacs && elisp-site-regen
}
