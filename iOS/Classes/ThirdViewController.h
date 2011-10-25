//
//  ThirdViewController.h
//  Mercury_iOS
//
//  Created by Julien Salvi on 9/12/11.
//  Copyright 2011 Mogreet Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ThirdViewController : UIViewController <UITextFieldDelegate> {
    IBOutlet UIButton *buttonSend;
    IBOutlet UITextField *campidSend;
    IBOutlet UITextField *clientSend;
    IBOutlet UITextField *contentidSend;
    IBOutlet UITextField *fromSend;
    IBOutlet UILabel *hashSend;
    IBOutlet UILabel *messSend;
    IBOutlet UITextField *messageSend;
    IBOutlet UILabel *messidSend;
    IBOutlet UILabel *respCodeSend;
    IBOutlet UILabel *respStatusSend;
    IBOutlet UITextField *toSend;
    IBOutlet UITextField *tokenSend;
}
- (IBAction)validateSend:(id)sender;
@end
