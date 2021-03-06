# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_PHP="php5-6 php7-0 php7-1 php7-2 php7-3"
PHP_EXT_NAME="stomp"
DOCS=( CREDITS doc/classes.php doc/functions.php )

inherit php-ext-pecl-r3

USE_PHP="php7-0 php7-1 php7-2 php7-3"

KEYWORDS="~amd64 ~x86"

DESCRIPTION="PHP extension to communicate with Stomp message brokers"
LICENSE="PHP-3.01"
SLOT="7"
IUSE="examples ssl test"

DEPEND="${DEPEND}
	php_targets_php7-0? ( dev-lang/php:7.0[ssl?] )
	php_targets_php7-1? ( dev-lang/php:7.1[ssl?] )
	php_targets_php7-2? ( dev-lang/php:7.2[ssl?] )
	php_targets_php7-3? ( dev-lang/php:7.3[ssl?] )
"

RDEPEND="${DEPEND}
	php_targets_php5-6? ( dev-php/pecl-stomp:0 )"

src_prepare() {
	if use php_targets_php7-0 || use php_targets_php7-1 || use php_targets_php7-2 || use php_targets_php7-3 ; then
		php-ext-source-r3_src_prepare
	else
		default
	fi
}

src_configure() {
	if use php_targets_php7-0 || use php_targets_php7-1 || use php_targets_php7_2 || use php_targets_php7-3 ; then
		local PHP_EXT_ECONF_ARGS=(
			--enable-stomp
			--with-openssl-dir=$(usex ssl "${EPREFIX}/usr")
		)
		php-ext-source-r3_src_configure
	fi
}

src_install() {
	if use php_targets_php7-0 || use php_targets_php7-1 || use php_targets_php7_2 || use php_targets_php7-3 ; then
		php-ext-pecl-r3_src_install
	fi
}
