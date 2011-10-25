//
//  TransactionsViewController.m
//  Mercury_iOS
//
//  Created by Julien Salvi on 9/12/11.
//  Copyright 2011 Mogreet Inc. All rights reserved.
//

#import "TransactionsViewController.h"
#import "Mercury.h"
#import "Transactions.h"

@implementation TransactionsViewController
- (IBAction)validateTrans:(id)sender {
	
	NSString *clientIDStr = clientTrans.text;
	int clientIDint = [clientIDStr intValue];
	NSString *token = tokenTrans.text;	
	
    Mercury *mercuryTrans = [[Mercury alloc] initMercury:clientIDint withToken:token];
	Transactions *newTrans = [[Transactions alloc] init];
	
	//Collecting the params (value-key) essential for the TRANSACTIONS call
	NSMutableDictionary *hash = [[NSMutableDictionary alloc] init];
	[hash setObject:numTrans.text forKey:@"number"];
	
	//Execution of the TRANSACTIONS call
	newTrans = [mercuryTrans transactions:hash];
	
	//Collecting data from the API call.
	NSString *mess = [newTrans getMessage];
	NSString *stat = [newTrans getResponseStatus];
	int code = [newTrans getResponseCode];
	NSMutableArray *campid = [newTrans getCampaignIDs];
	NSMutableArray *campname = [newTrans getCampaignNames];
	NSMutableArray *hashs = [newTrans getHashs];
	NSMutableArray *messid = [newTrans getMessageIDs];
	NSMutableArray *fromNum = [newTrans getFromNumbers];
	NSMutableArray *toNum = [newTrans getToNumbers];
	
	//Display the collected data.
	[respStatusTrans setText: [NSString stringWithFormat:@"Response Status: %@", stat]];
	[messTrans setText: [NSString stringWithFormat:@"Message: %@", mess]];
	[respCodeTrans setText: [NSString stringWithFormat:@"Response Code: %d", code]];
	[campidTrans setText: [NSString stringWithFormat:@"Camp ID: %@", [campid objectAtIndex:0]]];
	[campNameTrans setText: [NSString stringWithFormat:@"Campaign Name: %@", [campname objectAtIndex:0]]];
	[hashTrans setText: [NSString stringWithFormat:@"Hash: %@", [hashs objectAtIndex:0]]];
	[messidTrans setText: [NSString stringWithFormat:@"Message ID: %@", [messid objectAtIndex:0]]];
	[fromTrans setText: [NSString stringWithFormat:@"From: %@", [fromNum objectAtIndex:0]]];
	[toTrans setText: [NSString stringWithFormat:@"To: %@", [toNum objectAtIndex:0]]];
	
	[newTrans release];
	[mercuryTrans release];
	
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
	if (textField == clientTrans || textField == tokenTrans	|| textField == numTrans) {
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
