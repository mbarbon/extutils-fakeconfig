#!/usr/bin/perl -w

use strict;
use if $^O !~ /^darwin/, 'Test::More' => 'skip_all' => 'Not on Mac OS X';
use Test::More tests => 2;

use_ok( 'Config_u' );
use_ok( 'Config_osx' );
