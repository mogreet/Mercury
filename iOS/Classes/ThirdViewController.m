//
//  ThirdViewController.m
//  Mercury_iOS
//
//  Created by Julien Salvi on 9/12/11.
//  Copyright 2011 Mogreet Inc. All rights reserved.
//

#import "ThirdViewController.h"
#import "Mercury.h"
#import "Send.h"

@implementation ThirdViewController
- (IBAction)validateSend:(id)sender {
	
	NSString *clientIDStr = clientSend.text;
	int clientIDint = [clientIDStr intValue];
	NSString *token = tokenSend.text;
	
	Mercury *mercury = [[Mercury alloc] initMercury:clientIDint withToken:token];
	Send *mySend = [[Send alloc] init];
	
	//Collecting the params (value-key) essential for the SEND call
	NSMutableDictionary *hash = [[NSMutableDictionary alloc] init];
	[hash setObject:campidSend.text forKey:@"campaign_id"];
	[hash setObject:fromSend.text forKey:@"from"];
	[hash setObject:toSend.text forKey:@"to"];
	[hash setObject:messageSend.text forKey:@"message"];
	[hash setObject:contentidSend.text forKey:@"content_id"];
	
	//Execution of the SEND call and collecting data from the APi call.
	mySend = [mercury send:hash];
	NSString *mess = [mySend getMessage];
	NSString *stat = [mySend getResponseStatus];
	int code = [mySend getResponseCode];
	int messid = [mySend getMessageId];
	NSString *hashLabel = [mySend getHash];
	
	//Display the collected data.
	[respStatusSend setText: [NSString stringWithFormat:@"Response Status: %@", stat]];
	[messSend setText: [NSString stringWithFormat:@"Message: %@", mess]];
	[respCodeSend setText: [NSString stringWithFormat:@"Response Code: %d", code]];
	[messidSend setText: [NSString stringWithFormat:@"Message ID: %d", messid]];
	[hashSend setText: [NSString stringWithFormat:@"Hash: %@", hashLabel]];
	
	[mySend release];
	[mercury release];
    
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
	if (textField == clientSend || textField == tokenSend || textField == campidSend || textField == toSend || textField == fromSend || textField == messageSend || textField == contentidSend) {
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
