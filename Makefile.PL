#!/usr/bin/perl

use strict;
use lib 'lib';
use Config;
use ExtUtils::FakeConfig;

my $make;

BEGIN {
  if( $^O eq 'MSWin32' ) {
    $make = ( ExtUtils::FakeConfig::find_program( 'dmake', 'nmake' ) )[1];

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
             );

print "Using: '$make'\n";

my( @params, $templater );
BEGIN {
  $templater = '$(PERL) script/fill_template.pl';
  @params = ( { Module => 'Config_m.pm',
                Template => 'spec/Config_ap.txt',
                Spec => 'spec/ap_mingw.txt',
                Params => 'cc=gcc pack_name=Config_m' },
            );
}

package MY;

sub depend {
  my $this = shift;
  my $inst = $this->{INST_LIB};

  $this->SUPER::depend
    ( @_,
      ( $^O eq 'MSWin32' ?
        ( pure_all => ( join ' ',
          map { "$inst/" . $_->{Module} } @params ),
          map { ( "$inst/" . $_->{Module}, 'pm_to_blib' ) } @params,
        ) : () ),
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
  }

  return $ret;
}

# Local variables: #
# mode: cperl #
# End: #

