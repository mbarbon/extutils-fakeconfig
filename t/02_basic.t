#!/usr/bin/perl -w

use strict;
use Test;
BEGIN { plan tests => 3 }

use ExtUtils::FakeConfig make => 'my_make',
                         cc => 'my_cc',
                         xxrv => 'dummy';
use Config;

ok( $Config{make}, 'my_make' );
ok( $Config{cc}, 'my_cc' );
ok( $Config{xxrv}, 'dummy' );

# local variables:
# mode: cperl
# end:
