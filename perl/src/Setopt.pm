#--- Setopt.pm ---
 #!/usr/bin/perl -w

package Setopt;
use Error qw(:try);
use strict;
use Response;
our @ISA = qw(Response);

=head1 NAME
 
 Setopt - Contains the response from a setopt request to the Moms API
 
=cut

=head1 SYNOPSIS

=begin html
 
 <b>use</b> Setopt;</br>
 <b>new Setopt</b>($xmlDoc); #$xmlDoc is an xml file
 
=end html
 
=cut

=head1 DESCRIPTION
 
=begin html
 
 The Setopt object contains the response from a <A HREF="mercury.html#setopt">setopt</A> request to the Moms API.

=end html
 
=cut

my $campaignId;
my $campaignStatusCode;
my $campaignStatus;

=head1 CONSTRUCTOR
 
=head2 Setopt
 
=over 4
 
=item Setopt
 
 Creates a new Setopt response object.

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
        $campaignId=($this->SUPER::getData())->{campaign}[0]{id};
        $campaignStatusCode=($this->SUPER::getData())->{campaign}[0]{status}{code};
        $campaignStatus=($this->SUPER::getData())->{campaign}[0]{status}{content};
        
        #print elements
        printElts();
        
    	return bless($this,$class);

	} catch Error with{
    	my $ex = shift;
        print "\nAn error occured while parsing the XML data for the SETOPT call:".$ex;
    }
}

=head1 FUNCTIONS
 
=head2 getCampaignId
 
=over 4

=item getCampaignId()
 
=begin html
 
 <b>Returns</b> the campaign ID.
 
=end html

=back
 
=cut

sub getCampaignId {
    return $campaignId;
}

=head2 getCampaignStatusCode
 
=over 4
 
=item getCampaignStatusCode()
 
=begin html
 
 <b>Returns</b> the campaign status code.
 
=end html 

=back
 
=cut

sub getCampaignStatusCode {
    return $campaignStatusCode;
}

=head2 getCampaignStatus
 
=over 4
 
=item getCampaignStatus()
 
=begin html
 
 <b>Returns</b> the campaign status label.
 
=end html  
 
=back
 
=cut

sub getCampaignStatus {
    return $campaignStatus;
}

=head2 printElts
 
=over 4
 
=item printElts()
 
=begin html
 
 Prints all the elements.
 
=end html
 
=back
 
=cut

sub printElts {
    print "campaign Id: ".$campaignId."\n";
    print "campaign status code: ".$campaignStatusCode."\n";
    print "campaign status: ".$campaignStatus."\n";

}

=head1 AUTHOR
 
=begin html
 
 Anais Brossas for Mogreet (<A HREF="http://www.mogreet.com">www.mogreet.com</A>)</br>
 Date: Tuesday, October 04, 2011 
 
=end html
 
=cut

1;