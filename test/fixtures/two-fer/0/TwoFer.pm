package TwoFer;
use strict;
use warnings;
use Exporter 'import';
our @EXPORT_OK = qw(two_fer);

sub two_fer {
  my ($name) = @_;
	my $prase = "One for you, one for me.";
	if ($name) { 
	  $prase = "One for $name, one for me."; 
	}
  return $prase;
}

1;
