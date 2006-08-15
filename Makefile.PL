#!/usr/bin/perl

use strict;
use lib 'lib';
use Config;
use ExtUtils::FakeConfig;

my $make;

BEGIN {
  if( $^O eq 'MSWin32' ) {
    $make = $ENV{MAKE};
    $make ||= ( ExtUtils::FakeConfig::find_program( 'nmake', 'dmake' ) )[1];

    $make || die "Unable to find 'make' program";

    import ExtUtils::FakeConfig make => $make;
  }
}

use ExtUtils::MakeMaker;

my $liar = File::Spec->catfile( 'lib', 'ExtUtils', 'FakeConfig.pm' );

WriteMakefile( NAME => 'ExtUtils::FakeConfig',
               # Perl < 5.005 does not support some attributes
               ( $] >= 5.005 ?
                 ( ABSTRACT_FROM => $liar,
                   AUTHOR => 'Mattia Barbon <mbarbon@dsi.unive.it>',
                 ) : () ),
               VERSION_FROM => $liar,
               PREREQ_PM => { 'File::Spec'        => 0,
                              'Test::More'        => 0.48,
                              },
             );

print "Using: '$make'\n";

my( @params, $templater );
BEGIN {
  $templater = '$(PERL) script/fill_template.pl';
  @params = ( { Module   => 'Config_m.pm',
                Template => 'spec/Config_ap.txt',
                Spec     => ( $] >= 5.008
                              ? 'spec/ap_mingw_58.txt'
                              : 'spec/ap_mingw.txt' ),
                Params   => "cc=gcc pack_name=Config_m make=$make" },
            );
}

package MY;

use strict;
use Config;

sub depend {
  my $this = shift;
  my $inst = $this->{INST_LIB};

  my $extra_deps = join ' ', map { "$inst/" . $_->{Module} } @params;

  $this->SUPER::depend
    ( @_,
      ( $^O eq 'MSWin32' ?
        ( 'pm_to_blib'  => $extra_deps ) :
        () ),
    );
}

use vars qw(%i);

sub postamble {
  local( *i );
  my $ret;
  my $lib = $_[0]->{INST_LIB};

  if( $^O eq 'MSWin32' ) {
    foreach my $j ( @params ) {
      *i = $j;
      $ret .= <<EOT;
$lib/$i{Module} : $i{Template} $i{Spec}
	$templater $i{Template} $i{Spec} \$@ $i{Params}

EOT
    }

    my $lib_suff = $] >= 5.008 ? '58' : '56';
    $ret .= <<EOT;
implib :
	\$(PERL) script\\make_implib.pl --output-dir=$Config{prefix}\\lib\\CORE --output-lib=libperl${lib_suff}.a --target=mingw $Config{prefix}\\bin\\perl${lib_suff}.dll

pure_install :: implib
EOT
  }

  return $ret;
}

