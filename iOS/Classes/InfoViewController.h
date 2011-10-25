//
//  InfoViewController.h
//  Mercury_iOS
//
//  Created by Julien Salvi on 9/12/11.
//  Copyright 2011 Mogreet Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InfoViewController : UIViewController <UITextFieldDelegate> {
    IBOutlet UIButton *buttonInfo;
    IBOutlet UILabel *carrierInfo;
    IBOutlet UILabel *carrieridInfo;
    IBOutlet UITextField *clientInfo;
    IBOutlet UILabel *handsetInfo;
    IBOutlet UILabel *handsetidInfo;
    IBOutlet UILabel *messInfo;
    IBOutlet UITextField *numInfo;
    IBOutlet UILabel *numberInfo;
    IBOutlet UILabel *respCodeInfo;
    IBOutlet UILabel *respStatusInfo;
    IBOutlet UITextField *tokenInfo;
}
- (IBAction)validateInfo:(id)sender;
@end
