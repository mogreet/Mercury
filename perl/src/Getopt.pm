#--- Getopt.pm ---
 #!/usr/bin/perl -w

package Getopt;
use Error qw(:try);
use strict;
use Response;
our @ISA = qw(Response);

=head1 NAME
 
 Getopt - Contains the response from a getopt request to the Moms API
 
=cut

=head1 SYNOPSIS
 
=begin html
 
 <b>use</b> Getopt;</br>
 <b>new Getopt</b>($xmlDoc); #$xmlDoc is an xml file
 
=end html
 
=cut

=head1 DESCRIPTION
 
=begin html
 
 The Getopt object contains the response from a <A HREF="mercury.html#getopt">getopt</A> request to the Moms API.
 
=end html
 
=cut

my $campaigns;

=head1 CONSTRUCTOR
 
=head2 Getopt
 
=over 4
 
=item Getopt($xmlDoc)
 
 This function creates a new Getopt response object.
 
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
        $campaigns=$this->SUPER::getData();
        
        #print elements
        printElts();
        
    	return bless($this,$class);
        
    } catch Error with{
    	my $ex = shift;
        print "\nAn error occured while parsing the XML data for the GETOPT call:".$ex;
    }
}

=head1 FUNCTIONS

=head2 getCampaignsIdList
 
=over 4
 
=item getCampaignsIdList()
 
=begin html
 
 <b>Returns</b> the list of all the campaigns ID.
 
=end html

=back
 
=cut

sub getCampaignsIdList {
    my @campaignsIdList=();
    my $count = @{$campaigns->{campaign}}; #get the number of nodes in the xml file
    for (my $k=0;$k<$count;$k++){
		my $temp = ($campaigns->{campaign}[$k]{id});
    	@campaignsIdList=(@campaignsIdList,$temp);
    }
    return @campaignsIdList;
}

=head2 getCampaignStatusCode
 
=over 4
 
=item getCampaignStatusCode($campaignId)
 
=begin html
 
 <b>Returns</b> the status code of the specified campaign.
 0 if the specified campaign ID does not exist.

=end html

=back
 
=cut

sub getCampaignStatusCode {
    my ($campaignId) = @_;
	my $k;
	my $count = @{$campaigns->{campaign}}; #get the number of nodes in the xml file
	for ($k=0;$k<$count;$k++){
		if ($campaigns->{campaign}[$k]{id}==$campaignId){
    		return ($campaigns->{campaign}[$k]{status}{code});
    	}
	}
    return 0;   
}

=head2 getCampaignStatus
 
=over 4
 
=item getCampaignStatus($campaignId)
 
=begin html
 
 <b>Returns</b> the status label of the specified campaign.
 0 if the specified campaign ID does not exist.
 
=end html
 
=back
 
=cut

sub getCampaignStatus {
    my ($campaignId) = @_;
    my $k;
    my $count = @{$campaigns->{campaign}}; #get the number of nodes in the xml file
	for ($k=0;$k<$count;$k++){
		if ($campaigns->{campaign}[$k]{id}==$campaignId){
    		return ($campaigns->{campaign}[$k]{status}{content});
    	}
	}
    return 0;
}

=head2 printElts
 
=over 4
 
=item printElts()
 
=begin html
 
 Prints each campaign with its id, status code, content.
 
=end html 
 
=back 
 
=cut

sub printElts{
    my $k; 
    my $count = @{$campaigns->{campaign}}; #get the number of nodes in the xml file
	for ($k=0;$k<$count;$k++){
        print "campaign id = ".$campaigns->{campaign}[$k]{id}.", status code = ".$campaigns->{campaign}[$k]{status}{code}." : ".$campaigns->{campaign}[$k]{status}{content}."\n";  
    }
}

=head1 AUTHOR
 
=begin html
 
 Anais Brossas for Mogreet (<A HREF="http://www.mogreet.com">www.mogreet.com</A>)</br>
 Date: Tuesday, October 04, 2011 
  
=end html
 
=cut

1;