#!/usr/bin/perl -w

use strict;
use if $^O !~ /^MSWin/, 'Test::More' => 'skip_all' => 'Not on Windows';
use Test::More tests => 1;

use_ok( 'Config_m' );
