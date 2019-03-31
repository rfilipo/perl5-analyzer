use strict;
use warnings;
package Perl5::Analyzer;

use File::Slurp;
use Perl::Critic;

use Data::Dumper;

# ABSTRACT: Analyzes and tests Exercism exercises

sub new {
    my ($class, %args) = @_;
    return bless \%args, $class;
}

sub test {
    return 1;
}

sub analyze {
    my $self = shift;
    $self->{file} = shift;
    $self->{document} = read_file($self->{file});
    print Dumper $self;
    my $critic = Perl::Critic->new();
    my @violations = $critic->critique(\$self->{document});
    return @violations;
}

1;
