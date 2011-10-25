//
//  UncacheViewController.m
//  Mercury_iOS
//
//  Created by Julien Salvi on 9/12/11.
//  Copyright 2011 Mogreet Inc. All rights reserved.
//

#import "UncacheViewController.h"
#import "Mercury.h"
#import "Uncache.h"

@implementation UncacheViewController
- (IBAction)validateUncache:(id)sender {
	
	NSString *clientIDStr = clientUncache.text;
	int clientIDint = [clientIDStr intValue];
	NSString *token = tokenUncache.text;	
	
	Mercury *mercuryUn = [[Mercury alloc] initMercury:clientIDint withToken:token];
	Uncache *newUncache = [[Uncache alloc] init];
	
	////Collecting the params (value-key) essential for the UNCACHE call
	NSMutableDictionary *hash = [[NSMutableDictionary alloc] init];
	[hash setObject:numUncache.text forKey:@"number"];
	
	//Execution of the UNCACHE call
	newUncache = [mercuryUn uncache:hash];
	
	//Collecting data from the API call.
	NSString *mess = [newUncache getMessage];
	NSString *stat = [newUncache getResponseStatus];
	int code = [newUncache getResponseCode];
	NSString *num = [newUncache getNumber];
	
	//Display the collected data.
	[respStatusUncache setText: [NSString stringWithFormat:@"Response Status: %@", stat]];
	[messUncache setText: [NSString stringWithFormat:@"Message: %@", mess]];
	[respCodeUncache setText: [NSString stringWithFormat:@"Response Code: %d", code]];
	[numberUncache setText: [NSString stringWithFormat:@"Number: %@", num]];
	
	[newUncache release];
	[mercuryUn release];
	
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
	if (textField == clientUncache || textField == tokenUncache || textField == numUncache) {
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
