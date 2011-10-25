#--- Send.pm ---
#!/usr/bin/perl -w

package Send;
use Error qw(:try);
use strict;
use Response;
our @ISA = qw(Response);

=head1 NAME
 
 Send - Contains the response from a send request to the Moms API
 
=cut

=head1 SYNOPSIS
 
=begin html
 
 <b>use</b> Send;</br>
 <b>new Send</b>($xmlDoc); #$xmlDoc is an xml file
 
=end html
 
=cut

=head1 DESCRIPTION
 
=begin html
 
The Send object contains the response from a <A HREF="mercury.html#send">send</A>  request to the Moms API.
 
=end html
 
=cut

my $messageId;
my $hash;

=head1 CONSTRUCTOR
 
=head2 Send
 
=over 4
 
=item Send($xmlDoc)
 
 Creates a new Send response object.
 
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
        if (!($this->SUPER::responseIsValid()));
    try {  
        #Set the attributes
        $messageId=($this->SUPER::getData())->{message_id};
        $hash=($this->SUPER::getData())->{hash};

        #print elements
        printElts();
        
        return bless($this,$class);

    } catch Error with{
    	my $ex = shift;
        print "\nAn error occured while parsing the XML data for the SEND call:".$ex;
    }
}

=head1 FUNCTIONS

=head2 getMessageID
 
=over 4

=item getMessageID()
 
=begin html
 
 <b>Returns</b> the message ID.
 
=end html

=back
 
=cut

sub getMessageId {
	return $messageId;
}

=head2 getHash
 
=over 4
 
=item getHash()
 
=begin html
 
 <b>Returns</b> hash.
 
=end html
 
=back
 
=cut

sub getHash {
	return $hash;
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
    print "message Id: ".$messageId."\n";
    print "Hash: ".$hash."\n";
}

=head1 AUTHOR
 
=begin html
 
 Anais Brossas for Mogreet (<A HREF="http://www.mogreet.com">www.mogreet.com</A>)</br>
 Date: Tuesday, October 04, 2011 
 
=end html
 
=cut

1;