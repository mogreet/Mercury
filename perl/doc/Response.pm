#--- Response.pm ---
 #!/usr/bin/perl -w

package Response;
use Error qw(:try);
use XML::Simple qw(:strict);
use strict;
use Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(&reponseIsValid);

=head1 NAME
 
 Response - Super class for all the kind of responses that can be obtained from the Moms API requests
 
=cut

=head1 SYNOPSIS
 
=begin html
 
 <b>use</b> Response;</br>
 <b>new Response</b>($xmlDoc); #$xmlDoc is an xml file
 
=end html
 
=cut

=head1 DESCRIPTION
 
=begin html

 The Response object represents a response from the MoMS API (Mogreet Message System).</br>
 
 
 It is created by the <A HREF="mercury.html">Mercury</A> and it is the result of an API call to the MoMS.</br>
  
 Response is the super class for all the kind of responses that can be obtained from the Moms API requests (<A HREF="ping.html">Ping</A>, <A HREF="send.html">Send</A>, <A HREF="lookup.html">Lookup</A>, <A HREF="transactions.html">Transactions</A>, <A HREF="uncache.html">Uncache</A>, <A HREF="getopt.html">Getopt</A>, <A HREF="setopt.html">Setopt</A>, <A HREF="info.html">Info</A>).</br>
 
 It contains common methods for the subclasses.
 
=end html
 
=cut

our $xmlDoc;
my $responseCode;
my $responseStatus;
our $message; 
our $xml;
our $data;       

=head1 CONSTRUCTOR
 
=head2 Response
 
=over 4

=item Response($xmlDoc)
 
 Constructs a new Response object.
 
=begin html
 
 <b>Paramters</b>: $xmlDoc: XML document that is returned by all the requests.
 
=end html

=back
 
=cut

sub new {
	my ($class,$xmlDocR) = @_;
	$class = ref($class) || $class;
	my $this = {};
	$xmlDoc=$xmlDocR;
	setResponseCodeStatusMessage();
 	return bless ($this,$class);
}

=head1 FUNCTIONS
 
=head2 setResponseCodeStatusMessage
 
=over 4
 
=item setResponseCodeStatusMessage()
 
 This function set the different attributes of the response class using XML::Simple to parse the XML document
 
=back
 
=cut

sub setResponseCodeStatusMessage {
	try {        
        #create parser
        $xml = new XML::Simple;
        
        #read XML file
        $data = $xml->XMLin($xmlDoc, forcearray => [ qw(campaign) ], keyattr=>[]);
        
        #Set the attributes
        $responseStatus=$data->{status};
        $message=$data->{message};
        $responseCode=$data->{code};
        
        #print elements
        printElts();
        
    } catch Error with {
        my $ex = shift;
        print "\nAn error occured while getting the response code, status and message:".$ex;
    }
	
}

=head2 responseIsValid
 
=over 4
 
=item responseIsValid()
 
 Checks if the response code is 1,
 
=begin html
 
 <b>Returns</b> True (1) if the response code is 1, False (0) if it is not.
 
=end html
 
=back
 
=cut

sub responseIsValid {
	if($responseCode == 1){
		return 1; 	
	}else{
		return 0;
	}
}

=head2 getResponseCode
 
=over 4
 
=item getResponseCode()
 
=begin html
 
 <b>Returns</b> the response code.
 
=end html
 
=back
 
=cut

sub getResponseCode {
	return $responseCode;
}

=head2 getResponseStatus
 
=over 4
 
=item getResponseStatus()
 
=begin html
 
 <b>Returns</b> the response status.
 
=end html
 
=back 

=cut

sub getResponseStatus {
	return $responseStatus;
}

=head2 getMessage
 
=over 4
 
=item getMessage()
 
=begin html
 
 <b>Returns</b> the response message.
 
=end html
 
=back 
 
=cut

sub getMessage {
	return $message;
}

=head2 getData
 
=over 4
 
=item getData()
 
=begin html
 
 <b>Returns</b>XML data.
 
=end html
 
=back 
 
=cut

sub getData {
	return $data;
} 

=head2 printElts
 
=over 4
 
=item printElts()
  
 Prints the status code, message and code of the XML Document.
  
=back 
 
=cut

sub printElts {
    print "\nResponse: \n";
    if ($responseStatus !~m/\)$/){ # responseStatus is a word (not ended with ")" )
        print "status: ".$responseStatus."\n";
    }
    print "message: ".$message."\n";
    print "code: ".$responseCode."\n";
}

=head1 AUTHOR
 
=begin html
 
 Anais Brossas for Mogreet (<A HREF="http://www.mogreet.com">www.mogreet.com</A>)</br>
 Date: Tuesday, October 04, 2011 
 
=end html
 
=cut

1;
