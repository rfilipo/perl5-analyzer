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
    my $self = shift;
    $self->{test_file} = shift;
    my $cmd = "prove -v ".$self->{test_file};    
    my @output = `$cmd`;    
    chomp @output;
    #print Dumper @output;
    return @output;
}

sub analyze {
    my $self = shift;
    $self->{file} = shift;
    $self->{document} = read_file($self->{file});
    my $critic = Perl::Critic->new();
    my @violations = $critic->critique(\$self->{document});
    #print Dumper @violations;
    return @violations;
}

1;
