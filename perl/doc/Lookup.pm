#--- Lookup.pm ---
#!/usr/bin/perl -w

package Lookup;
use Error qw(:try);
use strict;
use Response;
our @ISA = qw(Response);

=head1 NAME
 
 Lookup - Contains the response from a lookup request to the Moms API
 
=cut

=head1 SYNOPSIS
 
=begin html
 
 <b>use</b> Lookup;</br>
 <b>new Lookup</b>($xmlDoc); #$xmlDoc is an xml file
 
=end html
 
=cut

=head1 DESCRIPTION
 
=begin html
 
 The Lookup object contains the response from a <A HREF="mercury.html#lookup">lookup</A> request to the Moms API.
 
=end html
 
=cut

my $campaigns;
my $campaignId;
my $fromNumber;
my $fromName;
my $toNumber;
my $toName;
my $contentId;
my $status;
my $history;

=head1 CONSTRUCTOR

=head2 Lookup
 
=over 4
 
=item Lookup($xmlDoc)
 
 Creates a new Lookup response object.
 
=begin html
 
 <b>Paramters</b>: $xmlDoc: XML document that is returned by all the requests.
 
=end html

=back
 
=cut

sub new{
	my ($class,$xmlDoc) = @_;
	$class = ref($class) || $class;
	my $this = $class->SUPER::new($xmlDoc);
	throw Error::Simple($this->SUPER::getMessage())	
        if (!$this->SUPER::responseIsValid());
    try {
		#Set the attributes
        $campaigns = $this->SUPER::getData();
        $campaignId=($this->SUPER::getData())->{campaign_id};
        $fromNumber=($this->SUPER::getData())->{from};
        $fromName=($this->SUPER::getData())->{from_name};
        $toNumber=($this->SUPER::getData())->{to};
        $toName=($this->SUPER::getData())->{to_name};
        $contentId=($this->SUPER::getData())->{content_id};
        $status=($this->SUPER::getData())->{status}[1];
        $history=($this->SUPER::getData())->{history};
        
        #print elements
        print "status: ".(($this->SUPER::getData())->{status}[0])."\n";
        printElts();
        
        return bless($this,$class);

    } catch Error with{
    	my $ex = shift;
        print "\nAn error occured while parsing the XML data for the LOOKUP call:".$ex;
    }
}

=head1 FUNCTIONS

=head2 getCampaignId
 
=over 4
 
=item getCampaignId()

=begin html
 
 <b>Returns</b> the campaign ID of the requested transaction.
 
=end html

=back
 
=cut

sub getCampaignId {
	return $campaignId;	
}

=head2 getFromNumber
 
=over 4
 
=item getFromNumber()
 
=begin html
 
 <b>Returns</b> the sender number of the requested transaction.
 
=end html 

=back
 
=cut

sub getFromNumber {
	return $fromNumber;
}

=head2 getFromName
 
=over 4
 
=item getFromName()
 
=begin html
 
 <b>Returns</b> the sender name of the requested transaction.
 
=end html

=back
 
=cut

sub getFromName {
	return $fromName;
}

=head2 getToNumber
 
=over 4
 
=item getToNumber()
 
=begin html
 
 <b>Returns</b> the receiver number of the requested transaction.
 
=end html

=back
 
=cut

sub getToNumber {
	return $toNumber;
}

=head2 getToName
 
=over 4
 
=item getToName()
 
=begin html
 
 <b>Returns</b> the receiver name of the requested transaction.
 
=end html
 
=back
 
=cut

sub getToName {
	return $toName;
}

=head2 getContentId
 
=over 4
 
=item getContentId()
 
=begin html
 
 <b>Returns</b> the content ID of the requested transaction.
 
=end html
 
=back
 
=cut

sub getContentId {
	return $contentId;
}

=head2 getStatus
 
=over 4 
	
=item getStatus()

=begin html
 
 <b>Returns</b> the status label of the requested transaction.
 
=end html

=back
 
=cut

sub getStatus {
	return $status;
}

=head2 getTimestampsList
 
=over 4 
 
=item getTimestampsList()
 
=begin html
 
 <b>Returns</b> the list of all the timestamps events of the requested transaction.
 
=end html
 
=back
 
=cut

sub getTimestampsList {
	my @timestamps;
    my $count = @{$campaigns->{history}{event}}; #get the number of events in the xml file
	for (my $k=0;$k<$count;$k++){
        @timestamps=(@timestamps,$campaigns->{history}{event}[$k]{timestamp});
    }
	return @timestamps;	
}

=head2 getEventList
 
=over 4 
 
=item getEventList()
 
=begin html
 
 <b>Returns</b> the list of all the events of the requested transaction.
 
=end html
 
=back

=cut

sub getEventsList {
	my @events;
    my $count = @{$campaigns->{history}{event}}; #get the number of events in the xml file
	for (my $k=0;$k<$count;$k++){
        @events=(@events,$campaigns->{history}{event}[$k]{content});
    }
	return @events;	
}

=head2 getEvents
 
=over 4 
 
=item getEvents($timestamp)
 
=begin html
 
 <b>Returns</b> the list of the events that occured at the specified timestamp of the requested transaction.
 Null if the specified timestamp does not exist.
 
=end html
 
=back
 
=cut

sub getEvents {
	my ($timestamp) = @_;
	my @listEvents;
    my $count = @{$campaigns->{history}{event}}; #get the number of events in the xml file
	for (my $k=0;$k<$count;$k++){
        if(($campaigns->{history}{event}[$k]{timestamp}) eq $timestamp){
            @listEvents=(@listEvents,$campaigns->{history}{event}[$k]{content});
        }
    }
	return 	@listEvents;
}

=head2 getEventsTC
 
=over 4

=item getEventsTC()
 
=begin html
 
 Prints all the events with their timestamp and content.
 
=end html

=back
 
=cut

sub getEventsTC{
    my $count = @{$campaigns->{history}{event}}; #get the number of events in the xml file
	for (my $k=0;$k<$count;$k++){
        print "event timestamp = ".$campaigns->{history}{event}[$k]{timestamp}." : ".$campaigns->{history}{event}[$k]{content}."\n"; 
    }
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
    print "campaign Id: ".$campaignId."\n";
    print "from: ".$fromNumber."\n";
    print "from name: ".$fromName."\n";
    print "to: ".$toNumber."\n";
    print "to name: ".$toName."\n";
    print "content Id: ".$contentId."\n";
    print "status: ".$status."\n";
    getEventsTC();
}

=head1 AUTHOR
 
=begin html
 
 Anais Brossas for Mogreet (<A HREF="http://www.mogreet.com">www.mogreet.com</A>)</br>
 Date: Tuesday, October 04, 2011 
 
=end html
 
=cut

1;



