# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_DEPEND="2:2.5"
EGIT_REPO_URI="git://anongit.freedesktop.org/telepathy/${PN}"

inherit python base cmake-utils git-2

DESCRIPTION="Qt4 bindings for the Telepathy D-Bus protocol"
HOMEPAGE="http://telepathy.freedesktop.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="debug farsight farstream test"

RDEPEND="
	x11-libs/qt-core:4
	x11-libs/qt-dbus:4
	farsight? (
		net-libs/telepathy-farsight
	)
	farstream? (
		net-libs/telepathy-farstream
		>=net-libs/telepathy-glib-0.17.5
	)
	!net-libs/telepathy-qt4
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	farsight? (
		>=net-libs/telepathy-glib-0.17.5
	)
	test? (
		dev-libs/dbus-glib
		dev-libs/glib
		dev-python/dbus-python
		x11-libs/qt-test:4
	)
"

REQUIRED_USE="farsight? ( !farstream )"

PATCHES=( "${FILESDIR}/${P}-automagicness.patch" )
DOCS=( AUTHORS ChangeLog HACKING NEWS README )

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with farsight)
		$(cmake-utils_use_with farstream)
		$(cmake-utils_use_enable debug DEBUG_OUTPUT)
		$(cmake-utils_use_enable test)
		-DENABLE_EXAMPLES=OFF
	)
	cmake-utils_src_configure
}