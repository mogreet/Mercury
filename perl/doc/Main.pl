#--- Main.pl ---
#!/usr/bin/perl -w

use strict;
use Mercury qw(:DEFAULT);

my $clientId;
my $token;
my $entre;
my $m;

# Creates a new Mercury Object
sub intialiseMercury{
    print "--------------------------------------------\n";
	print "-------------- Mogreet SDK -----------------\n";
	print "--------------------------------------------\n";
	print "--------- INITIALISE YOUR OBJECT -----------\n"; 
	print "--------------------------------------------\n";
	print "--------------------------------------------\n";
    print "------------- Enter Client Id --------------\n";
    print "--------------------------------------------\n";
    $clientId = <STDIN>;
    print "--------------------------------------------\n";
    print "--------------- Enter Token ----------------\n";
    print "--------------------------------------------\n";
    $token = <STDIN>;
    
    #checks if the client id and the token are empty or not
    chomp($clientId);
    chomp($token);
    if ((length ($clientId) == 0) || (length ($token) == 0) ){
        throw Error::Simple("Error: Client Id and Token are required!");
    }
    
    #creates a new Mercury Object
    $m = new Mercury($clientId,$token);
    
}

#prints list of possible requests to the MoMS API
sub menu {
	print "--------------------------------------------\n";
	print "-------------- Mogreet SDK -----------------\n";
	print "--------------------------------------------\n";
	print "--------- PING :         Enter 1 -----------\n"; 
	print "--------- LOOKUP :       Enter 2 -----------\n"; 
	print "--------- SEND :         Enter 3 -----------\n"; 
	print "--------- GETOPT :       Enter 4 -----------\n";
	print "--------- SETOPT :       Enter 5 -----------\n"; 
	print "--------- UNCACHE :      Enter 6 -----------\n"; 
	print "--------- INFO :         Enter 7 -----------\n"; 
	print "--------- TRANSACTIONS : Enter 8 -----------\n";
	print "--------------------------------------------\n";
	print "--------- Enter any letter to quit ---------\n";
	print "--------------------------------------------\n";
}

# calls the function that initialises the object with a token and a Client ID
intialiseMercury();

# calls the function that prints the menu with alle the kind of requests that can be done 
menu();

# recovers the value entered
$entre = <STDIN>;

# if the value doesn't fit with the code of a request, it quits the application
if ($entre !~m/[1-8]/){
		print "------------------ GOODBYE -----------------\n"; 
}else{ # do the request 
	while ($entre =~m/[1-8]/){
		if ($entre == 1){ #ping request
			print "\n--------------------------------------------\n";
			print "------------------- PING -------------------\n"; 
			print "--------------------------------------------\n";
			
            # Ping on the object created at the beginning
			$m->ping();	
			
		} else {
			if ($entre == 2){ #lookup request
				print "\n--------------------------------------------\n";
				print "------------------ LOOKUP ------------------\n"; 
				print "--------------------------------------------\n";
				print "------------ Enter Message Id --------------\n";
                print "--------------------------------------------\n";
				my $messageId = <STDIN>;
                print "--------------------------------------------\n";
				print "--------------- Enter Hash -----------------\n";
                print "--------------------------------------------\n";
				my $hash = <STDIN>;
				
                # creates hash with values entered
				my %hash=("message_id"=>$messageId,"hash"=>$hash);
                # Lookup on the object created at the beginning
                $m->lookup(\%hash);

			}
			else{
				if ($entre == 3){ #send request
                    print "\n--------------------------------------------\n";
                    print "------------------- SEND -------------------\n"; 
                    print "--------------------------------------------\n";
                    print "------------ Enter Campaign Id -------------\n";
                    print "--------------------------------------------\n";
                    my $campaignId = <STDIN>;
                    print "--------------------------------------------\n";
                    print "---------------- Enter To ------------------\n";
                    print "--------------------------------------------\n";
                    my $to = <STDIN>;
                    print "--------------------------------------------\n";
                    print "--------------- Enter Message --------------\n";
                    print "--------------------------------------------\n";
                    my $message = <STDIN>;
                    print "--------------------------------------------\n";
                    print "------------- Enter Content Id -------------\n";
                    print "--------------------------------------------\n";
                    my $contentId = <STDIN>;
                    
                    my %hash=("campaign_id"=>$campaignId,"to"=>$to,"message"=>$message,"content_id"=>$contentId);
                    # Send on the object created at the beginning
                    $m->send(\%hash);	
				}
				else{
					if ($entre == 4){ #getopt request
                        print "\n--------------------------------------------\n";
                        print "------------------ GETOPT ------------------\n"; 
                        print "--------------------------------------------\n";
                        print "--------------- Enter Number ---------------\n";
                        print "--------------------------------------------\n";
                        my $number = <STDIN>;

                        my %hash=("number"=>$number);
                        # Getopt on the object created at the beginning
                        $m->getopt(\%hash);	
					
					}
					else{
						if ($entre == 5){ #setopt request
                            print "\n--------------------------------------------\n";
                            print "------------------ SETOPT ------------------\n"; 
                            print "--------------------------------------------\n";
                            print "--------------- Enter Number ---------------\n";
                            print "--------------------------------------------\n";
                            my $number = <STDIN>;
                            print "--------------------------------------------\n";
                            print "------------ Enter Campaign Id -------------\n";
                            print "--------------------------------------------\n";
                            my $campaignId = <STDIN>;
                            print "--------------------------------------------\n";
                            print "------------ Enter Status Code -------------\n";
                            print "--------------------------------------------\n";
                            my $statusCode = <STDIN>;

                            my %hash=("number"=>$number,"campaign_id"=>$campaignId,"status_code"=>$statusCode);
                            # Setopt on the object created at the beginning
                            $m->setopt(\%hash);	
						}
						else{
							if ($entre == 6){ #uncache request
                                print "\n--------------------------------------------\n";
                                print "----------------- UNCACHE ------------------\n"; 
                                print "--------------------------------------------\n";
                                print "--------------- Enter Number ---------------\n";
                                print "--------------------------------------------\n";
                                my $number = <STDIN>;
                                
                                my %hash=("number"=>$number);
                                # Uncache on the object created at the beginning
                                $m->uncache(\%hash);	
							}
							else{
								if ($entre == 7){ #info request
                                    print "\n--------------------------------------------\n";
                                    print "------------------ INFO --------------------\n"; 
                                    print "--------------------------------------------\n";
                                    print "--------------- Enter Number ---------------\n";
                                    print "--------------------------------------------\n";
                                    my $number = <STDIN>;
						
                                    my %hash=("number"=>$number);
                                    # Info on the object created at the beginning
                                    $m->info(\%hash);	
								}
								else{
									if ($entre == 8){ #transactions request
                                        print "\n--------------------------------------------\n";
                                        print "-------------- TRANSACTIONS ----------------\n"; 
                                        print "--------------------------------------------\n";
                                        print "--------------- Enter Number ---------------\n";
                                        print "--------------------------------------------\n";
                                        my $number = <STDIN>;
                                        print "--------------------------------------------\n";
                                        print "------------ Enter Campaign Id -------------\n";
                                        print "--------------------------------------------\n";
                                        my $campaignId = <STDIN>;
                                        
                                        my %hash=("number"=>$number,"campaign_id"=>$campaignId);
                                        # Transactions on the object created at the beginning
                                        $m->transactions(\%hash);
									}
									else{ #quits the application
										print "------------------ GOODBYE -----------------\n"; 
									}
								}
							}
						}	
					}
				}
			}
		}

	menu();
	$entre=<STDIN>;
	if ($entre !~m/[1-8]/){
		print "------------------ GOODBYE -----------------\n"; 
		}
	}
}


