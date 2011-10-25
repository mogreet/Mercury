//
//  SecondViewController.m
//  Mercury_iOS
//
//  Created by Julien Salvi on 9/12/11.
//  Copyright 2011 Mogreet Inc. All rights reserved.
//

#import "SecondViewController.h"
#import "Mercury.h"
#import "FirstViewController.h"
#import "Lookup.h"

@implementation SecondViewController
- (IBAction)validateLookup:(id)sender {
	
	NSString *clientIDStr = clientLook.text;
	int clientIDint = [clientIDStr intValue];
	NSString *token = tokenLook.text;
	
    Mercury *mercuryLook = [[Mercury alloc] initMercury:clientIDint withToken:token];
	Lookup *newLook = [[Lookup alloc] init];
	
	//Collecting the params (value-key) essential for the LOOKUP call
	NSMutableDictionary *hash = [[NSMutableDictionary alloc] init];
	[hash setObject:messidLook.text forKey:@"message_id"];
	[hash setObject:hashLook.text forKey:@"hash"];
	
	//Execution of the LOOKUP call
	newLook = [mercuryLook lookup:hash];
	
	//Collecting data from the API call.
	NSString *mess = [newLook getMessage];
	NSString *stat = [newLook getResponseStatus];
	int code = [newLook getResponseCode];
	int campid = [newLook getCampaignId];
	NSString *from = [newLook getFromNumber];
	NSString *fromname = [newLook getFromName];
	NSString *to = [newLook getToNumber];
	NSString *toname = [newLook getToName];
	int contentid = [newLook getContentId];
	NSString *status = [newLook getStatus];
	
	//Collecting the events of the history
	NSMutableArray *event = [newLook getEventsList];
	
	//Display the collected data.
	[respStatusLook setText: [NSString stringWithFormat:@"Response Status: %@", stat]];
	[messLook setText: [NSString stringWithFormat:@"Message: %@", mess]];
	[respCodeLook setText: [NSString stringWithFormat:@"Response Code: %d", code]];
	[campidLook setText: [NSString stringWithFormat:@"Campaign ID: %d", campid]];
	[fromNumLook setText: [NSString stringWithFormat:@"From Number: %@", from]];
	[fromNameLook setText: [NSString stringWithFormat:@"From Name: %@", fromname]];
	[toNumLook setText: [NSString stringWithFormat:@"To Number: %@", to]];
	[toNameLook setText: [NSString stringWithFormat:@"To Name: %@", toname]];
	[contentidLook setText: [NSString stringWithFormat:@"Content ID: %d", contentid]];
	[statusLook setText: [NSString stringWithFormat:@"Status: %@", status]];
	[eventLook setText: [NSString stringWithFormat:@"Events: %@", [event objectAtIndex:0]]];
	
	[newLook release];
	[mercuryLook release];
	
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
	if (textField == clientLook || textField == tokenLook || textField == messidLook || textField == hashLook) {
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
