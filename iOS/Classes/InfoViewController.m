//
//  InfoViewController.m
//  Mercury_iOS
//
//  Created by Julien Salvi on 9/12/11.
//  Copyright 2011 Mogreet Inc. All rights reserved.
// 

#import "InfoViewController.h"
#import "Mercury.h"
#import "Info.h"

@implementation InfoViewController
- (IBAction)validateInfo:(id)sender {
	
	NSString *clientIDStr = clientInfo.text;
	int clientIDint = [clientIDStr intValue];
	NSString *token = tokenInfo.text;	
	
	Mercury *mercuryInfo = [[Mercury alloc] initMercury:clientIDint withToken:token];
	Info *newInfo = [[Info alloc] init];
	
	//Collecting the params (value-key) essential for the INFO call
	NSMutableDictionary *hash = [[NSMutableDictionary alloc] init];
	[hash setObject:numInfo.text forKey:@"number"];
	
	//Execution of the INFO call
	newInfo = [mercuryInfo info:hash];
	
	//Collecting data from the API call.
	NSString *mess = [newInfo getMessage];
	NSString *stat = [newInfo getResponseStatus];
	int code = [newInfo getResponseCode];
	NSString *num = [newInfo getNumber];
	NSString *carr = [newInfo getCarrier];
	int carrid = [newInfo getCarrierId];
	NSString *handset = [newInfo getHandset];
	int handsetid = [newInfo getHandsetId];
	
	//Display the collected data.
	[respStatusInfo setText: [NSString stringWithFormat:@"Response Status: %@", stat]];
	[messInfo setText: [NSString stringWithFormat:@"Message: %@", mess]];
	[respCodeInfo setText: [NSString stringWithFormat:@"Response Code: %d", code]];
	[numberInfo setText: [NSString stringWithFormat:@"Number: %@", num]];
	[carrierInfo setText: [NSString stringWithFormat:@"Carrier: %@", carr]];
	[carrieridInfo setText: [NSString stringWithFormat:@"Carrier ID: %d", carrid]];
	[handsetInfo setText: [NSString stringWithFormat:@"Handset: %@", handset]];
	[handsetidInfo setText: [NSString stringWithFormat:@"Handset ID: %d", handsetid]];
	
	[newInfo release];
	[mercuryInfo release];
	
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
	if (textField == clientInfo || textField == tokenInfo || textField == numInfo) {
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
