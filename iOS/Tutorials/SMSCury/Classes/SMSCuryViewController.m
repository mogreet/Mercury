//
//  SMSCuryViewController.m
//  SMSCury
//
//  Created by Julien Salvi on 9/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SMSCuryViewController.h"
#import "Mercury.h"
#import "Send.h"

@implementation SMSCuryViewController
- (IBAction)sendSMS:(id)sender {
	
	NSString *token;
	int clientID;
	/////////////////////////////////////////////
    // Initialize you token and your Client ID //
	token = @"102ed2ad568f913a31aeace02eeae234";
	clientID = 536;
	/////////////////////////////////////////////
	
	Mercury *mercury = [[Mercury alloc] initMercury:clientID withToken:token];
	Send *smsSend = [[Send alloc] init];
	
	//Collecting data to make a SEND call
	NSMutableDictionary *hash = [[NSMutableDictionary alloc] init];
	//////////////////////////////////////////////////
	// Enter your own campaign ID to make SEND call //
	//////////////////////////////////////////////////
	[hash setObject:@"10651" forKey:@"campaign_id"];
	[hash setObject:fromNumber.text forKey:@"from"];
	[hash setObject:toNumber.text forKey:@"to"];
	[hash setObject:messageSMS.text forKey:@"message"];
	
	//Sending request to the Mogreet API
	smsSend = [mercury send:hash];
	
	NSString *deliver = [smsSend getMessage];
	[messDelivered setText: [NSString stringWithFormat:@"MESSAGE DELIVERED: %@", deliver]];
	
	[smsSend release];
	[mercury release];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
	if (textField == fromNumber || textField == toNumber || textField == messageSMS) {
		[textField resignFirstResponder];
	}
	return YES;
}




/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
