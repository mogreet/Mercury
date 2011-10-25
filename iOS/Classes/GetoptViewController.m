//
//  GetoptViewController.m
//  Mercury_iOS
//
//  Created by Julien Salvi on 9/12/11.
//  Copyright 2011 Mogreet Inc. All rights reserved.
//

#import "GetoptViewController.h"
#import "Mercury.h"
#import "Getopt.h"

@implementation GetoptViewController
- (IBAction)validateGetopt:(id)sender {
	
	NSString *clientIDStr = clientGetopt.text;
	int clientIDint = [clientIDStr intValue];
	NSString *token = tokenGetopt.text;
	
	Mercury *mercuryGet = [[Mercury alloc] initMercury:clientIDint withToken:token];
	Getopt *newGet = [[Getopt alloc] init];
	
	//Collecting the params (value-key) essential for the GETOPT call
	NSMutableDictionary *hash = [[NSMutableDictionary alloc] init];
	[hash setObject:numGetopt.text forKey:@"number"];
	[hash setObject:campidGetopt.text forKey:@"campaign_id"];
	
	//Execution of the GETOPT call
	newGet = [mercuryGet getopt:hash];
	
	//Collecting data from the API call.
	NSString *mess = [newGet getMessage];
	NSString *stat = [newGet getResponseStatus];
	int code = [newGet getResponseCode];
	NSMutableArray *campStatus = [[NSMutableArray alloc] init]; 
	campStatus = [newGet getCampaignStatusList];
	NSMutableArray *statusCode = [[NSMutableArray alloc] init];
	statusCode = [newGet getCampaignStatusCodeList];
	
	//Display the collected data.
	[respStatusGetopt setText: [NSString stringWithFormat:@"Response Status: %@", stat]];
	[messGetopt setText: [NSString stringWithFormat:@"Message: %@", mess]];
	[respCodeGetopt setText: [NSString stringWithFormat:@"Response Code: %d", code]];
	[campStatusCodeGetopt setText: [NSString stringWithFormat:@"Status Code: %@", [statusCode objectAtIndex:0]]];
	[campStatusGetopt setText: [NSString stringWithFormat:@"Campaign Status: %@", [campStatus objectAtIndex:0]]];
	
	[newGet release];
	[mercuryGet release];	
    
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
	if (textField == clientGetopt || textField == tokenGetopt || textField == numGetopt || textField == campidGetopt) {
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
