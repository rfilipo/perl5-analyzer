#!/usr/bin/env perl

use strict;
use warnings;
use File::Find::Rule;
use lib 'lib';
use Perl5::Analyzer;
use JSON;

use Data::Dumper;

my $slug     = shift;
my $path     = shift;
my $dir      = $path . $slug;
my $analyzer = Perl5::Analyzer->new;

my @modules = File::Find::Rule->file()->name('*.pm')->in($dir);
my @tests = File::Find::Rule->file()->name('*.t')->in($dir);
my $result = {status=>"refer to mentor", comments=>[]};

for (@tests) {
    my $test = process_test($_);
    if (grep /FAIL/, @{$test}){
      $result->{status} = "disapprove_with_comment";
      push (@{$result->{comments}}, "Test fail, fix your code! Verify the errors: ");
      push (@{$result->{comments}}, $_) for (grep /not ok/, @{$test});
    }
}
for (@modules) {
    my $anlz = process_anlz($_);
    for (@{$anlz}){
       if ($_->description() =~ /OPTIMAL/){
           $result->{status} = "approve_as_optimal";
       } else {
           $result->{status} = "approve_with_comment";
           push (@{$result->{comments}}, "Some advices to be better: ");
           push (@{$result->{comments}}, $_->description());
       }
    } 
}

my $json = to_json $result;

print $json;

sub process_test {
    my $file = shift;
    my @pass = $analyzer->test($file);
    return \@pass;
}

sub process_anlz {
    my $file = shift;
    my @result = $analyzer->analyze($file);
    return \@result;
}

=pod

=head1 DESCRIPTION
 
Tests and analyzes all fixtures of an exercise.
Each fixture must be inside a diferent directory bellow the slug name

=head1 USAGE
 
    /usr/bin/env perl ./bin/analyze.pl slug_of_exercise path_to_exercises_dir

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

