#--- Uncache.pm ---
#!/usr/bin/perl -w

package Uncache;
use Error qw(:try);
use strict;
use Response;
our @ISA = qw(Response);

=head1 NAME
 
 Uncache - Contains the response from a uncache request to the Moms API
 
=cut

=head1 SYNOPSIS
 
=begin html
 
 <b>use</b> Uncache;</br>
 <b>new Uncache</b>($xmlDoc); #$xmlDoc is an xml file
 
=end html
 
=cut

=head1 DESCRIPTION
 
=begin html
 
 The Uncache object contains the response from a <A HREF="mercury.html#uncache">uncache</A> request to the Moms API.
 
=end html
 
=cut

my $number;

=head1 CONSTRUCTOR
 
=head2 Uncache
 
=over 4
 
=item Uncache($xmlDoc)
 
 Creates a new Uncache response object.

=begin html
 
 <b>Paramters</b>: $xmlDoc: XML document that is returned by all the requests.
 
=end html
 
=back
 
=cut

sub new {
	my ($class,$xmlDoc) = @_;
	$class = ref($class) || $class;
	my $this = $class->SUPER::new($xmlDoc);
	throw Error::Simple($this->SUPER::getMessage())	
    	if (!($this->SUPER::responseIsValid()));
    try {
        #Set the attribute
        $number=($this->SUPER::getData())->{number};
        
        #print elements
        printElts();
        
        return bless($this,$class);

    } catch Error with {
    	my $ex = shift;
        print "\nAn error occured while parsing the XML data for the UNCACHE call:".$ex;
    }
}

=head1 FUNCTIONS
 
=head2 getNumber
 
=over 4

=item getNumber()
 
=begin html
 
 <b>Returns</b> the number of the uncached phone.
 
=end html
 
=back
  
=cut

sub getNumber {
	return $number;
}

=head2 printElts
 
=over 4
 
=item printElts()
 
=begin html
 
 Prints all the elements.
 
=end hml
 
=back
 
=cut

sub printElts {
    print "number: ".$number."\n";

}

=head1 AUTHOR
 
=begin html
 
 Anais Brossas for Mogreet (<A HREF="http://www.mogreet.com">www.mogreet.com</A>)</br>
 Date: Tuesday, October 04, 2011 
 
=end html
 
=cut

1;