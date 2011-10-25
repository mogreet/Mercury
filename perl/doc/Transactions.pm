#--- Transactions.pm ---
 #!/usr/bin/perl -w

package Transactions;
use strict;
use Error qw(:try);
use Response;
our @ISA = qw(Response);

=head1 NAME
 
 Transactions - Contains the response from a transactions request to the Moms API
 
=cut

=head1 SYNOPSIS
 
=begin html
 
 <b>use</b> Transactions;</br>
 <b>new Transactions</b>($xmlDoc); #$xmlDoc is an xml file
 
=end html
 
=cut

=head1 DESCRIPTION
 
=begin html
 
 The Transactions object contains the response from a <A HREF="mercury.html#transactions">transactions</A> request to the Moms API.
 
=end html
 
=cut

my $campaigns;

=head1 CONSTRUCTOR
 
=head2 Transactions
 
=over 4

=item Transactions($xmlDoc)
 
 Creates a new Transactions response object.

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
        if($campaigns->{message} ne "no user transactions found"){
            printElts();
        }
        
        return bless($this,$class);
        
    } catch Error with{
    	my $ex = shift;
        print "\nAn error occured while parsing the XML data for the TRANSACTIONS call:".$ex;
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

sub getCampaignIdList {
	my @campaignsIdList;
	my $count = @{$campaigns->{campaign}};#get the number of campaigns in the xml file
    for (my $k=0;$k<$count;$k++){
		my $temp = ($campaigns->{campaign}[$k]{id});
    	@campaignsIdList=(@campaignsIdList,$temp);
    }
    return @campaignsIdList;
}

=head2 getCampaignNames
 
=over 4
 
=item getCampaignNames($campaignId)
 
=begin html
 
 <b>Returns</b> the names for the specified campaign ID (a campaign can have more than one name).

=end html
 
=back
  
=cut

sub getCampaignNames {
	my ($campaignId) = @_;
	my @campaignNames;
    my $count = @{$campaigns->{campaign}};#get the number of campaigns in the xml file
    for (my $k=0;$k<$count;$k++){
		my $temp = ($campaigns->{campaign}[$k]{id});
        if ($temp==$campaignId){ #get the name if the campaign ID matches
            my $name=$campaigns->{campaign}[$k]{name};
            @campaignNames=(@campaignNames,$name);
        }
    }
    return @campaignNames;
}

=head2 getTransactionsIdList
 
=over 4
 
=item getTransactionsIdList()
 
=begin html
 
 <b>Returns</b> the list of all the transactions ID.
 
=end html
 
=back
  
=cut

sub getTransactionsIdList {
	my @transactionsIdList;
    my $count = @{$campaigns->{campaign}};#get the number of campaigns in the xml file
    for (my $k=0;$k<$count;$k++){
        my $temp = ($campaigns->{campaign}[$k]{transaction}{message_id});
    	@transactionsIdList=(@transactionsIdList,$temp);
    }
    return @transactionsIdList;
}

=head2 getTransactionsIdListFrom
 
=over 4
 
=item getTransactionsIdListFrom($campaignId)
 
=begin html
 
 <b>Returns</b> the list of all the transactions ID for the specified campaign ID.
 
=end html
 
=back
 
=cut

sub getTransactionsIdListFrom {
	my ($campaignId) = @_;
	my @campaignTransactions;
    my $count = @{$campaigns->{campaign}};#get the number of campaigns in the xml file
    for (my $k=0;$k<$count;$k++){
		my $temp = ($campaigns->{campaign}[$k]{id});
        if ($temp==$campaignId){ #get the name if the campaign ID matches
            my $transaction=$campaigns->{campaign}[$k]{transaction}{message_id};
            @campaignTransactions=(@campaignTransactions,$transaction);
        }
    }
    return @campaignTransactions;	
}

=head2 getValue
 
=over 4
 
=item getValue($campaignId,$transactionId,$key)
 
=begin html
 
 <b>Returns</b> the value for the specified key.
 
=end html
  
=back
 
=cut

sub getValue{
	my ($campaignId,$transactionId,$key) = @_;
    my $value;
    my $count = @{$campaigns->{campaign}};#get the number of campaigns in the xml file
    for (my $k=0;$k<$count;$k++){
		my $tempId = ($campaigns->{campaign}[$k]{id});
        my $tempTr = ($campaigns->{campaign}[$k]{transaction}{message_id});
        if ($tempId==$campaignId){ #get the name if the campaign ID matches
            if($tempTr==$transactionId){
                if ($key eq "from_number"){
                    $value = $campaigns->{campaign}[$k]{transaction}{from}{number};
                }else{
                    if ($key eq "from_name"){
                        $value = $campaigns->{campaign}[$k]{transaction}{from}{content};
                    }else{
                        if($key eq "to_number"){
                            $value = $campaigns->{campaign}[$k]{transaction}{to}{number};
                        }else{
                            if ($key eq "to_name"){
                                $value = $campaigns->{campaign}[$k]{transaction}{to}{content};
                            }else{
                                $value = $campaigns->{campaign}[$k]{transaction}{$key};
                            }
                        }
                    }
                }
                print $value."\n";
                return $value;
            }
        }
    }
    
}

=head2 getHash
 
=over 4
 
=item getHash($campaignId,$transactionId)

=begin html
 
 <b>Returns</b> the hash corresponding to the specified campaign ID and transaction ID. Null if the campaign ID or the transaction ID does not exist.

=end html
 
=back
  
=cut

sub getHash {
	my ($campaignId,$transactionId) = @_;
	return getValue($campaignId,$transactionId,"hash");
}

=head2 getDatestamp
 
=over 4
 
=item getDatestamp($campaignId,$transactionId)
 
=begin html
 
 <b>Returns</b> the datestamp corresponding to the specified campaign ID and transaction ID. Null if the campaign ID or the transaction ID does not exist.
 
=end html
 
=back
 
=cut

sub getDatestamp {
	my ($campaignId,$transactionId) = @_;
	return getValue($campaignId,$transactionId,"datestamp");	
}

=head2 getFromNumber
 
=over 4
 
=item getFromNumber($campaignId,$transactionId)
 
=begin html
 
 <b>Returns</b> the sender's number corresponding to the specified campaign ID and transaction ID. Null if the campaign ID or the transaction ID does not exist.
 
=end html
 
=back
  
=cut

sub getFromNumber {	
	my ($campaignId,$transactionId) = @_;
	return getValue($campaignId,$transactionId,"from_number");	
}

=head2 getFromName
 
=over 4
 
=item getFromName($campaignId,$transactionId)
 
=begin html
 
 <b>Returns</b> the sender's name corresponding to the specified campaign ID and transaction ID. Null if the campaign ID or the transaction ID does not exist.
 
=end html
 
=back
 
=cut

sub getFromName {
	my ($campaignId,$transactionId) = @_;
	return getValue($campaignId,$transactionId,"from_name");	
}	

=head2 getToNumber
 
=over 4

=item getToNumber($campaignId,$transactionId)
 
=begin html
 
 <b>Returns</b> the receiver's number corresponding to the specified campaign ID and transaction ID. Null if the campaign ID or the transaction ID does not exist.
 
=end html
 
=back
 
=cut

sub getToNumber {
	my ($campaignId,$transactionId) = @_;
	return getValue($campaignId,$transactionId,"to_number");	
}	

=head2 getToName
 
=over 4
 
=item getToName($campaignId,$transactionId) 

=begin html
 
 <b>Returns</b> the receiver's name corresponding to the specified campaign ID and transaction ID. Null if the campaign ID or the transaction ID does not exist.
 
=end html
 
=back
  
=cut

sub getToName {
	my ($campaignId,$transactionId) = @_;
	return getValue($campaignId,$transactionId,"to_name");	
}

=head2 printElts
 
=over 4
 
=item printElts()
 
=begin html
 
 Prints each campaign with its informations.
 
=end html
 
=back
  
=cut

sub printElts {
    my $count = @{$campaigns->{campaign}};#get the number of campaigns in the xml file
    for (my $k=0;$k<$count;$k++){
        print "campaign id = ".$campaigns->{campaign}[$k]{id}.", name = ".$campaigns->{campaign}[$k]{name}."\n";
        print "     transaction datestamp = ".$campaigns->{campaign}[$k]{transaction}{datestamp}.", hash = ".$campaigns->{campaign}[$k]{transaction}{hash}.", message Id = ".$campaigns->{campaign}[$k]{transaction}{message_id}."\n";
        print "         from number = ".$campaigns->{campaign}[$k]{transaction}{from}{number}." : ".$campaigns->{campaign}[$k]{transaction}{from}{content}.", to number = ".$campaigns->{campaign}[$k]{transaction}{to}{number}." : ".$campaigns->{campaign}[$k]{transaction}{to}{content}."\n";
    }
}

=head1 AUTHOR
 
=begin html
 
 Anais Brossas for Mogreet (<A HREF="http://www.mogreet.com">www.mogreet.com</A>)</br>
 Date: Tuesday, October 04, 2011 
 
=end html
 
=cut

1;	
	
	
	