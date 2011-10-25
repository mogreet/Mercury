#--- Info.pm ---
#!/usr/bin/perl -w

package Info;
use Error qw(:try);
use strict;
use Response;
our @ISA = qw(Response);

=head1 NAME
 
 Info - Contains the response from an info request
 
=cut

=head1 SYNOPSIS
 
=begin html
 
 <b>use</b> Info;</br>
 <b>new Info</b>($xmlDoc); #$xmlDoc is an xml file
 
=end html
 
=cut

=head1 DESCRIPTION
 
=begin html
 
 The Info object contains the response from a <A HREF="mercury.html#info">info</A> request to the Moms API.
 
=end html
 
=cut

my $number;
my $carrierId;
my $carrier;
my $handsetId;
my $handset;

=head1 CONSTRUCTOR
 
=head2 Info
 
=over 4

=item Info($xmlDoc)
 
 This function creates a new Info response object.
 
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
    	#Set the attributes
        $number=($this->SUPER::getData())->{number};
        $carrierId=($this->SUPER::getData())->{carrier}{id};
		$carrier=($this->SUPER::getData())->{carrier}{content};
		$handsetId=($this->SUPER::getData())->{handset}{id};
		$handset=($this->SUPER::getData())->{handset}{content};
    	
        #print elements
        printElts();
        
        return bless($this,$class);

    } catch Error with{
    	my $ex = shift;
        print "\nAn error occured while parsing the XML data for the INFO call:".$ex;
    }
}

=head1 FUNCTIONS
 
=head2 getNumber
 
=over 4

=item getNumber()
 
=begin html
 
 <b>Returns</b> the requested number.
 
=end html
 
=back
 
=cut

sub getNumber {
    return $number;
}

=head2 getCarrierId
 
=over 4
 
=item getCarrierId()
 
=begin html
 
 <b>Returns</b> carrier Id for the requested number.
 
=end html
  
=back
 
=cut

sub getCarrierId {
    return $carrierId;
}

=head2 getCarrier
 
=over 4
 
=item getCarrier()
 
=begin html
 
 <b>Returns</b> carrier name for the requested number.
 
=end html 
 
=back
 
=cut

sub getCarrier {
    return $carrier;
}

=head2 getHandsetId
 
=over 4
 
=item getHandsetId()
 
=begin html
 
 <b>Returns</b> handest Id for the requested number.
 
=end html 
 
=back
 
=cut

sub getHandsetId {
    return $handsetId;
}

=head2 getHandset
 
=over 4
 
=item getHandset()
 
=begin html
 
 <b>Returns</b> handset name for the requested number.
 
=end html 
 
=back
 
=cut

sub getHandset {
    return $handset;
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
    print "carrier Id: ".$carrierId."\n";
    print "carrier: ".$carrier."\n";
    print "handset Id: ".$handsetId."\n";
    print "handset: ".$handset."\n";
}

=head1 AUTHOR
 
=begin html
 
 Anais Brossas for Mogreet (<A HREF="http://www.mogreet.com">www.mogreet.com</A>)</br>
 Date: Tuesday, October 04, 2011 
 
=end html
 
=cut

1;