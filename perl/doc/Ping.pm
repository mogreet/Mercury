#--- Ping.pm ---
#!/usr/bin/perl -w

=head1 NAME
 
 Ping - Contains the response from a ping request
 
=cut

=head1 SYNOPSIS
 
=begin html
 
 <b>    use</b> Ping;</br>
 <b>    new Ping</b>($xmlDoc); #$xmlDoc is an xml file
 
=end html
 
=cut

=head1 DESCRIPTION
 
=begin html
 
 The Ping object contains the response from a <A HREF="mercury.html#ping">ping</A> request to the Moms API.
 
=end html
 
=cut

package Ping;
use Error qw(:try);
use strict;
use Response;
our @ISA = qw(Response);
use Getopt::Long ();

=head1 CONSTRUCTOR
 
=head2 Ping
 
=over 4
 
=item Ping($xmlDoc)
 
  Creates a new Ping response object.
 
=begin html
 
 <b>Parameters</b>: $xmlDoc : XML document that is returned by all the requests.
 
=end html
 
=back
 
=cut

sub new {
	my ($class,$xmlDoc) = @_;
	$class = ref($class) || $class;
	my $this = $class->SUPER::new($xmlDoc);
	throw Error::Simple($this->SUPER::getMessage()) 	
    if (!$this->SUPER::responseIsValid());
	return bless($this,$class);
}

=head1 AUTHOR
 
=begin html
 
 Anais Brossas for Mogreet (<A HREF="http://www.mogreet.com">www.mogreet.com</A>)</br>
 Date: Tuesday, October 04, 2011 
 
=end html
 
=cut

1;