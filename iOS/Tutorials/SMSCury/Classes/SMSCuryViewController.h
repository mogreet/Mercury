//
//  SMSCuryViewController.h
//  SMSCury
//
//  Created by Julien Salvi on 9/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMSCuryViewController : UIViewController <UITextFieldDelegate> {
    IBOutlet UIButton *buttonSend;
    IBOutlet UITextField *fromNumber;
    IBOutlet UILabel *messDelivered;
    IBOutlet UITextField *messageSMS;
    IBOutlet UITextField *toNumber;
}
- (IBAction)sendSMS:(id)sender;
@end

