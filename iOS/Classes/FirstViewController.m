//
//  FirstViewController.m
//  Mercury_iOS
//
//  Created by Julien Salvi on 9/12/11.
//  Copyright 2011 Mogreet Inc. All rights reserved.
//

#import "FirstViewController.h"
#import "Mercury.h"
#import "Ping.h"

@implementation FirstViewController

- (IBAction)validatePing:(id)sender {
	NSString *clientIDStr = clientPing.text;
	int clientIDint = [clientIDStr intValue];
	NSString *token = tokenPing.text;
	
    mercury = [[Mercury alloc] initMercury:clientIDint withToken:token];
	Ping *newPing = [[Ping alloc] init];
	newPing = [mercury ping];
	
	//Getting what we need
	NSString *mess = [newPing getMessage];
	NSString *stat = [newPing getResponseStatus];
	int code = [newPing getResponseCode];
		
	[respStatus setText: [NSString stringWithFormat:@"Response Status: %@", stat]];
	[messPing setText: [NSString stringWithFormat:@"Message: %@", mess]];
	[respCodePing setText: [NSString stringWithFormat:@"Response Code: %d", code]];
	
	[newPing release];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
	if (textField == clientPing || textField == tokenPing) {
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
