//
//  SetoptViewController.m
//  Mercury_iOS
//
//  Created by Julien Salvi on 9/12/11.
//  Copyright 2011 Mogreet Inc. All rights reserved.
//

#import "SetoptViewController.h"
#import "Mercury.h"
#import "Setopt.h"

@implementation SetoptViewController
- (IBAction)validateSetopt:(id)sender {
	
	NSString *clientIDStr = clientSetopt.text;
	int clientIDint = [clientIDStr intValue];
	NSString *token = tokenSetopt.text;	
    
	Mercury *mercurySet = [[Mercury alloc] initMercury:clientIDint withToken:token];
	Setopt *newSet = [[Setopt alloc] init];
	
	//Collecting the params (value-key) essential for the SETOPT call
	NSMutableDictionary *hash = [[NSMutableDictionary alloc] init];
	[hash setObject:numSetopt.text forKey:@"number"];
	[hash setObject:campidSetopt.text forKey:@"campaign_id"];
	[hash setObject:campStatusCodeSetopt.text forKey:@"status_code"];
	
	//Execution of the SETOPT call
	newSet = [mercurySet setopt:hash];
	
	//Collecting data from the API call.
	NSString *mess = [newSet getMessage];
	NSString *stat = [newSet getResponseStatus];
	int code = [newSet getResponseCode];
	int campid = [newSet getCampaignId];
	int campstatuscode = [newSet getCampaignStatusCode];
	NSString *campstatus = [newSet getCampaignStatus];
	
	//Display the collected data.
	[respStatusSetopt setText: [NSString stringWithFormat:@"Response Status: %@", stat]];
	[messSetopt setText: [NSString stringWithFormat:@"Message: %@", mess]];
	[respCodeSetopt setText: [NSString stringWithFormat:@"Response Code: %d", code]];
	[campIDSet setText: [NSString stringWithFormat:@"Camp ID: %d", campid]];
	[statusCodeSetopt setText: [NSString stringWithFormat:@"Status Code: %d", campstatuscode]];
	[campStatusSetopt setText: [NSString stringWithFormat:@"Campaign Status: %@", campstatus]];
	
	[newSet release];
	[mercurySet release];
	
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
	if (textField == clientSetopt || textField == tokenSetopt || textField == numSetopt || textField == campidSetopt || textField == campStatusCodeSetopt) {
		[textField resignFirstResponder];
	}
	return YES;
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
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
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
