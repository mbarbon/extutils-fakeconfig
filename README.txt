ExtUtils::FakeConfig - overrides some configuration values
Config_m             - allows to build modules for ActivePerl with MinGW GCC

Mattia Barbon <mbarbon@dsi.unive.it>

for installation details see INSTALL.txt

* ExtUtils::FakeConfig

This module is meant to be used in module installation,
in case you need an easy way to override some configuration values.

* Config_m

It is just a front-end to ExtUtils::FakeConfig: sets up %Config to allow
compilation of ActivePerl modules with MinGW GCC.

Tested modules/OS

Module             Version         OS
DBD::CSV           0.1022          Win2k
DBD::ODBC          0.28            Win2k
DBI                1.14            Win2k
SQL::Statement     0.1016          Win2k
Text::CSV_XS       0.20            Win2k
wxPerl             0.04            Win2k

If you succeed in building these modules under other OS 
 ( expecially 95/98/ME ), or other modules not listed there, please
 contact me so I can update the list.

The latest version of this document may be found at

http://wxperl.sourceforge.net/ap_mingw/

Copyright (c) 2001-2002 Mattia Barbon. All rights reserved.
 This program is free software; you can redistribute it and/or
 modify it under the same terms as Perl itself.
