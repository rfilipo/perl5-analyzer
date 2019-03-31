use strict;
use warnings;
package Perl::Critic::Policy::Exercism::TwoFer;

use Readonly;

use Perl::Critic::Utils qw{ :severities :classification :ppi };
use base 'Perl::Critic::Policy';
 
our $VERSION = '0.01';

Readonly::Scalar my $DESC          => q{OPTIMAL: exercise "TwoFer"};
Readonly::Scalar my $EXPL          => undef;
Readonly::Scalar my $SEVERITY_HIGH => 5;

sub supported_parameters { return ()                  }
sub default_severity     { return $SEVERITY_HIGH      }
sub default_themes       { return qw( core exercism more ) }
sub applies_to           { return 'PPI::Document'  }
sub violates {
    my ( $self, $elem, undef ) = @_;
    return $self->violation( $DESC, $EXPL, $elem );
}

1;

=pod
 
=head1 NAME
 
Perl::Critic::Policy::Exercism::TwoFer
 
 
=head1 DESCRIPTION
 
Analyses the exercise two-fer for a good answer


 
 
=cut
