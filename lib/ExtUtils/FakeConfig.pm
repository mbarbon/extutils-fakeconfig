package ExtUtils::FakeConfig;

require Config;

use vars qw($VERSION);

$VERSION = 0.04;

eval {
  require File::Spec;
};
if( $@ ) {
  eval <<'EOT';
package File::Spec;

sub catfile { shift; join '/', @_ }

sub path { split /$Config::Config{path_sep}/, $ENV{PATH} }
EOT
}

sub import {
  shift;
  my $obj = tied %Config::Config;
  my $key;

  while( $key = shift ) {
    $obj->{$key} = shift;
  }
}

sub find_program {
  my @path = File::Spec->path();

  foreach my $prog ( map { ( $_, "$_.exe" ) } @_ ) {
    foreach my $path ( @path ) {
      if( -f File::Spec->catfile( $path, $prog ) ) {
        $prog =~ s/\.exe//;
        return ( $path, $prog );
      }
    }
  }

  return;
}

1;
__END__

=head1 NAME

ExtUtils::FakeConfig - overrides some configuration values

=head1 SYNOPSIS

  use ExtUtils::FakeConfig cc => 'gcc', make => 'gmake';

=head1 DESCRIPTION

This module is basically an hack to be used in Makefile.PL invocation:
create a driver module like

package my_Config:

use ExtUtils::FakeConfig cflags => '-lfoo -O14', ld => 'g++';

1;

and invoke

perl -Mmy_Config Makefile.PL

=head1 AUTHOR

Mattia Barbon <mbarbon@dsi.unive.it>

=cut

# Local variables: #
# mode: cperl #
# End: #
