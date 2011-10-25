//
//  FirstViewController.h
//  Mercury_iOS
//
//  Created by Julien Salvi on 9/12/11.
//  Copyright 2011 Mogreet Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mercury.h"

@interface FirstViewController : UIViewController<UITextFieldDelegate> {
    IBOutlet UIButton *buttonPing;
    IBOutlet UILabel *messPing;
    IBOutlet UITextField *clientPing;
    IBOutlet UILabel *respCodePing;
    IBOutlet UILabel *respStatus;
    IBOutlet UITextField *tokenPing;
	
	Mercury *mercury;
	
}

- (IBAction)validatePing:(id)sender;
@end
