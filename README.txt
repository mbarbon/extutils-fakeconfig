ExtUtils::FakeConfig - allows overriding some %Config values
Config_m             - allows building modules for ActivePerl with MinGW GCC

Mattia Barbon <mbarbon@cpan.org>

for installation details see INSTALL.txt

* ExtUtils::FakeConfig

  This module is meant to be used in module installation,
in case you need an easy way to override some configuration values.

* Config_m

  It is just a front-end to ExtUtils::FakeConfig: sets up %Config to allow
compilation of ActivePerl modules with MinGW GCC.

Tested modules/OS

Module          Version         Perl version    OS
DBD::CSV        0.1022          5.6.1           Win2k
DBD::ODBC       0.28              "               "
DBI             1.14              "               "
SQL::Statement  0.1016            "               "
Text::CSV_XS    0.20              "               "
wxPerl          0.17              "               "
wxPerl          0.17            5.8.0           Win2k
Text::CSV_XS    0.23              "             WinXP
Devel::Cover    0.26              "               "
Template Tookit 2.20              "               "
wxPerl          0.56            5.8.8           Win2k

  If you succeed in building some modules under other OSs
(expecially 95/98/ME), please contact me so I can update the list.

Copyright (c) 2001-2002, 2006 Mattia Barbon. All rights reserved.
This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.
