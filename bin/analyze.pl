#!/usr/bin/env perl

use strict;
use warnings;
use lib 'lib';
use Perl5::Analyzer;
use JSON;

use Data::Dumper;

my $slug     = shift;
my $file     = shift;
my $analyzer = Perl5::Analyzer->new;

my @pass   = $analyzer->test ($file);

my @result = $analyzer->analyze ($file);

print Dumper \@result;

my $json_result = to_json \@result;
print $json_result;

=pod

=head1 DESCRIPTION
 
Analyses the exercise two-fer for a good answer


=head1 USAGE
 
    /usr/bin/env perl ./bin/analyze.pl slug_of_exercise file_to_analyze

=cut

__DATA__

{
  "status": "...",
  "comments": [
    {
      "comment": "ruby.general.some_paramaterised_message",
      "params": { "foo": "param1", "bar": "param2" }
    }, 
    {
      "comment": "ruby.general.some_paramaterised_message"
    },
    "ruby.general.some_paramaterised_message"
  ]
}

