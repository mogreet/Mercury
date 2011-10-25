#--- Mercury.pm ---
 #!/usr/bin/perl -w

package Mercury;
use Ping;
use Send;
use Lookup;
use Getopt;
use Setopt;
use Uncache;
use Info;
use Transactions;
use strict;
use Data::Dumper;
use LWP::Simple;
use URI::URL;
use Error qw(:try);
our @EXPORT = qw(&processRequest &setParams &checkInputParams &ping &send &lookup &getopt &setopt &info &uncache &transactions);
use Pod::Usage ();
use Pod::Tree;

=head1 NAME
 
 Mercury - Allows to execute three types of requests to the MoMS API.
 
=cut

=head1 SYNOPSIS
 
=begin html
 
 <b>use</b> Mercury;</br>
 <b>new Mercury</b>($clientId,$token);
 
=end html
 
=cut

=head1 DESCRIPTION
 
=begin html
 
 The Mercury is an object that allows to execute three types of requests (system(<A HREF="ping.html">Ping</A>), user(<A HREF="getopt.html">Getopt</A>, <A HREF="setopt.html">Setopt</A>, <A HREF="info.html">Info</A>, <A HREF="uncache.html">Uncache</A>, <A HREF="transactions.html">Transactions</A>) and transaction(<A HREF="lookup.html">Lookup</A>, <A HREF="send.html">Send</A>)) to the MoMS (Mogreet Messaging System) API. </br>
 The MoMS (Mogreet Message System) is a dynamic SMS, MMS, and email messaging system which supports many different clients, many different campaigns, 
 many different message flows, many different aggregators and many different carriers.
 
=end html
 
=cut

my $PING_URL = "https://api.mogreet.com/moms/system.ping?";
my $SEND_URL = "https://api.mogreet.com/moms/transaction.send?";
my $LOOKUP_URL = "https://api.mogreet.com/moms/transaction.lookup?";
my $GETOPT_URL = "https://api.mogreet.com/moms/user.getopt?";
my $SETOPT_URL = "https://api.mogreet.com/moms/user.setopt?";
my $UNCACHE_URL = "https://api.mogreet.com/moms/user.uncache?";
my $INFO_URL = "https://api.mogreet.com/moms/user.info?";
my $TRANSACTIONS_URL = "https://api.mogreet.com/moms/user.transactions?";

my $clientId;
my $token;
our $params;
our $xmlDoc;
my %hash;

=head1 CONSTRUCTOR
 
=head2 Mercury
 
=over 4
 
=item new Mercury($clientId,$token)
 
 Constructs a new Mercury.
 
=begin html
 
 <b>Parameters</b>:
 
=end html
 
    - $clientId - Client ID
    - $token - Token

=back 
 
=cut

sub new {
	my ($class,$clientIdR,$tokenR) = @_;
    
	$class = ref($class) || $class;
	my $this = {};
    
    #Set the attributes
	$clientId = $clientIdR;
 	$token = $tokenR;
    
 	return bless($this,$class);
}
  
=head1 FUNCTIONS
 
=head2 processRequest
 
=over 4
 
=item processRequest($url,$params,$reqName)
 
 Returns a XML document which content is the XML response of the processed request.
 
=begin html
 
 <b>Parameters</b> :
 <ul>
    <li>$url: <i>Client ID</i>
    <li>$params: <i>Parameters string formatted as URL parameters (param1=value1&amp;param2=value2&amp;param3=value3&amp;...)</i>
    <li>$reqName: <i>Request's name</i>
 </ul>
 <b>Returns</b>: a XML Document

=end html

=back
 
=cut

sub processRequest{
	my ($url,$params,$reqName) = @_;
    try {
        #Constructs url
        my $unencoded=$url.$params;
        my $urlObj = URI::URL->new($unencoded);
        
        #Recovers data from the page and constructs XML object
        $xmlDoc=get $urlObj;
        die "Couldn't get url" unless defined $xmlDoc;
        return $xmlDoc;        

    }
    catch Error with{
        my $ex = shift;
        print "\nAn error occured while sending the ".$reqName." request: ".$ex;
    }
}

=head2 setParams
 
=over 4
 
=item setParams()
 
 Returns a URL format string created HashMap key-value pairs.
 
=begin html
 
 <b>Parameters</b>:
 <ul>
    <li>%hash - List of parameters (param_name-param_value pairs)
 </ul>
 <b>Returns</b> a URL format string: param1=value1&amp;param2=value2&amp;param3=value3&amp;...
 
=end html
 
=back
 
=cut

sub setParams{
    try {
        #chomp take \n off
        chomp($clientId);
        chomp($token);
        
        $params="client_id=".$clientId."&token=".$token;
        
        while( my($k,$v) = each(%hash)){
            chomp($v);
            $params=$params."&".$k."=".$v;
        }      
        return $params;
        
    } catch Error with {
        my $ex = shift;
        print $ex;
    }
}

=head2 ping
 
=over 4
 
=item ping()
 
 Tests connectivity to the Moms API servers.
 
=begin html
 <pre>
 <b>Code sample:</b> 
    $myMercury->ping();
 </pre> 
 <b>Returns</b> a new Ping response object.

=end html
 
=back
 
=cut

sub ping {
    setParams();
    $xmlDoc = processRequest($PING_URL, $params, "PING");

    return new Ping($xmlDoc);
}

=head2 send
 
=over 4
 
=item send(\%hash)
 
 Initiates a transaction and delivery of an SMS or MMS.
 
=begin html
 
 <pre>
 <b>Code sample:</b> 
    my %hash=("campaign_id"=>$campaignId,"to"=>$to,"message"=>$message,"content_id"=>$contentId);
    $myMercury->send(\%hash);
 </pre>
 <b>Paramters</b>: $hash: A HashMap object that must contain the following keys with their corresponding value:
 <ul>
    <li> "campaign_id" => "...": <i>An ID connected to a specific campaign setup in the Campaign Manager or provided by your account representative.</i>
 	<li> "to" => "...": <i>A 10-digit mobile phone number.</i>
    <li> "message" => "...": <i>Depending on your campaign set up, the message presented to the "to" user.</i>
  	<li> "content_id" => "...": <i>An ID associated to the content being sent (optional - depending on your campaign set up, this parameter may be required).</i>
 </ul>
 <b>Returns</b> a new Send response object.

=end html
 
=back

=cut

sub send {
    my ($this,$refHash)=@_;
    my $message;
    my $to;
    my $contentId;
    my $campaignId;
    my $i=0;
    
    #constructs hash given in parameters
    while(my($key,$value) = each %$refHash){
        $hash{$key}=$value;
        if ($i==0){
            $campaignId=$value;
        }else{
            if($i==1){
                $to=$value;
            }else{
                if($i==2){
                    $message=$value;
                }else{
                    $contentId=$value;
                }
            }
        }
        $i++;
    }
    
    # Check if all the params contain a value
    if (!(defined($campaignId)) || !(defined($to)) || !(defined($contentId)) || !(defined($message))){
        throw Error::Simple("Error: input parameter(s) missing in the SEND call.");
    }    
    my $params = setParams();
    my $xmlDoc = processRequest($SEND_URL, $params, "SEND");
    return new Send($xmlDoc);
}

=head2 lookup
 
=over 4
 
=item lookup(\%hash)
 
 Returns the info, status and history of the requested transaction.
 
=begin html
 
 <pre>
 <b>Code sample:</b> 
    my %hash=("message_id"=>$messageId,"hash"=>$hash);
    $myMercury->lookup(\%hash);
 </pre>
 <b>Parameters</b>: $hash: A HashMap object that must contains the following keys with their corresponding value:
 <ul>
 <li> "message_id" => "...": <i>An ID returned from a <A HREF="#send">send</A> or from <A HREF="#transactions">transactions</A> method.</i>
 	<li> "hash" => "...": <i>A hash returned from a <A HREF="#send">send</A> or from a <A HREF="#transactions">transactions</A> method.</i>
  </ul>
 <b>Returns</b> a new Lookup response object.
 
=end html
 
=back
 
=cut

sub lookup {
    my ($this,$refHash)=@_;
    my $messageId;
    my $hash;
    my $i=0;
    
    #constructs hash given in parameters
    while(my($key,$value) = each %$refHash){
        $hash{$key}=$value;
        if ($i==0){
            $hash=$value;
        }else{
            $messageId=$value;
        }
        $i++;
    }
    
    #check if values given in parameters are not empty
    if(!(defined($messageId))||!(defined($hash))){
        throw Error::Simple("Error: input parameter(s) missing in the LOOKUP call.\n");
    }
    my $params = setParams();
    my $xmlDoc = processRequest($LOOKUP_URL, $params, "LOOKUP");
    return new Lookup($xmlDoc);
}
 
=head2 getopt
 
=over 4
 
=item getopt(\%hash)
 
 Returns the opt in status of any mobile number.
 
=begin html
 
 <pre>
 <b>Code sample:</b>
    my %hash=("number"=>$number);
    $myMercury->getopt(\%hash);
 </pre>
 <b>Paramters</b>: $hash: A HashMap object that must contains the following keys with their corresponding value:
 <ul>
    <li>"number" => "...": <i>A 10-digit mobile phone number.</i>
 </ul>
 <b>Returns</b> a new Getopt response object.
 
=end html
 
=back

=cut

sub getopt {
    my ($this,$refHash)=@_;
    my $number;
    
    #constructs hash given in parameters
    while(my($key,$value) = each %$refHash){
        $hash{$key}=$value;
        $number=$value;        
    }
    
    if (!(defined($number))){
        throw Error::Simple("Error: input parameter(s) missing in the GETOPT call.");
    }
    my $params = setParams();
    my $xmlDoc = processRequest($GETOPT_URL, $params, "GETOPT");
    return new Getopt($xmlDoc);
}

=head2 setopt
 
=over 4
 
=item setopt(\%hash)
 
 Sets the opt in status of any mobile number.

=begin html
 
 <pre>
 <b>Code sample:</b>
    my %hash=("number"=>$number,"campaign_id"=>$campaignId,"status_code"=>$statusCode);
    $myMercury->setopt(\%hash);
 </pre>
 <b>Parameters</b>: $hash: A HashMap object that must contains the following keys with their corresponding value:
 <ul>
 	<li> "number" => "...": <i>A 10-digit mobile phone number.</i>
 	<li> "campaign_id" => "...": <i>An ID connected to a specific campaign setup in the Campaign Manager or provided by your account representative.</i>
 	<li> "status_code" => "...": <i>See the bellow table for available codes to use here.</i>
  </ul>
 
  <table border="1">
  	<tr>
  		<td>Status</td>
  		<td>Status code</td>
 		<td>Description</td>
 	</tr>
  	<tr>
  		<td>OPTEDIN</td>
  		<td>1</td>
 		<td>User is opted into the campaign</td>
  	</tr>
  	<tr>
  		<td>OPTEDOUT</td>
 		<td>-2</td>
 		<td>User is opted out of the campaign</td>
  	</tr>
  </table>
  <br />
 
 <b>Returns</b> a new Setopt response object.
 
=end html

=back
 
=cut

sub setopt {
    my ($this,$refHash)=@_;
    my $number;
    my $campaignId;
    my $statusCode;
    my $i=0;
    
    #constructs hash given in parameters
    while(my($key,$value) = each %$refHash){
        $hash{$key}=$value;
        if ($i==0){
            $statusCode=$value;
        }else{
            if ($i==1){
                $campaignId=$value;
            }else{
                $number=$value;
            }
        }
        $i++;
    }
    
    if (!(defined($number)) || !(defined($campaignId)) || !(defined($statusCode))){
        throw Error::Simple("Error: input parameter(s) missing in the SETOPT call.");
    }
    my $params = setParams();
    my $xmlDoc = processRequest($SETOPT_URL, $params, "SETOPT");
    return new Setopt($xmlDoc);
}
 
=head2 uncache
 
=over 4
 
=item uncache(\%hash)
 
 Clears the user carrier and handset info from the Mogreet cache.
 
=begin html
 
 <pre>
 <b>Code sample:</b>
    my %hash=("number"=>$number);
    $myMercury->uncache(\%hash);
 </pre>
 <b>Parameters</b>: $hash: A HashMap object that must contains the following keys with their corresponding value:
 <ul>
    <li>"number" => "...": <i>A 10-digit mobile phone number.</i>
 </ul>
 <b>Returns</b> a new Uncache response object.
 
=end html
 
=back

=cut

sub uncache {
    my ($this,$refHash)=@_;
    my $number;
    
    #constructs hash given in parameters
    while(my($key,$value) = each %$refHash){
        $hash{$key}=$value;
        $number=$value;        
    }
    
    if (!(defined($number))){
        throw Error::Simple("Error: input parameter(s) missing in the UNCACHE call.");
    }
    my $params = setParams();
    my $xmlDoc = processRequest($UNCACHE_URL, $params, "UNCACHE");
    return new Uncache($xmlDoc);
} 

=head2 info
 
=over 4
 
=item info(\%hash)
 
 Returns the user carrier and handset info if available.
 
=begin html
 
 <pre>
 <b>Code sample:</b>
    my %hash=("number"=>$number);
    $myMercury->info(\%hash);
 </pre>
 <b>Parameters</b>: $hash: A HashMap object that must contains the following keys with their corresponding value:
 <ul>
    <li>"number" => "...": <i>A 10-digit mobile phone number.</i>
 </ul>
 <b>Returns</b> a new Info response object.
 
=end html
 
=back
 
=cut

sub info {
    my ($this,$refHash)=@_;
    my $number;
    
    #constructs hash given in parameters
    while(my($key,$value) = each %$refHash){
        $hash{$key}=$value;
        $number=$value;        
    }
    
    if (!(defined($number))){
        throw Error::Simple("Error: input parameter(s) missing in the INFO call.");
    }
    my $params = setParams();
    my $xmlDoc = processRequest($INFO_URL, $params, "INFO");
    return new Info($xmlDoc);
} 
 
=head2 transactions
 
=over 4
 
=item transactions(\%hash)
 
 Returns the user's transactions (open and closed).
 
=begin html
 
 <pre>
 <b>Code sample:</b>
    my %hash=("number"=>$number,"campaign_id"=>$campaignId);
    $myMercury->transactions(\%hash);
 </pre>
 <b>Parameters</b>: $hash: A HashMap object that must contains the following keys with their corresponding value:
 <ul>
    <li>"campaign_id" => "...": <i>A campaign id to search on, if excluded, returns all transactions for the client's campaigns.</i>
    <li>"start_date" => "...": <i>Narrow search by adding a date to start searching on (YYYY-MM-DD).</i>
    <li>"end_date" => "...": <i>Narrow search by adding a date to stop searching on (YYYY-MM-DD).</i>
 </ul>
 <b>Returns</b> a new Info response object.

=end html
 
=back
 
=cut

sub transactions {
    my ($this,$refHash)=@_;
    my $number;
    
    #constructs hash given in parameters
    while(my($key,$value) = each %$refHash){
        $hash{$key}=$value;
        $number=$value;        
    }
    
    if (!(defined($number))){
        throw Error::Simple("Error: input parameter(s) missing in the TRANSACTIONS call.");
    }
    my $params = setParams();
    my $xmlDoc = processRequest($TRANSACTIONS_URL, $params, "TRANSACTIONS");
    return new Transactions($xmlDoc);
} 

=head1 AUTHOR
 
=begin html
 
 Anais Brossas for Mogreet (<A HREF="http://www.mogreet.com">www.mogreet.com</A>)</br>
 Date: Tuesday, October 04, 2011 
 
=end html
 
=cut

1;