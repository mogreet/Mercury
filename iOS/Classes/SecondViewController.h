//
//  SecondViewController.h
//  Mercury_iOS
//
//  Created by Julien Salvi on 9/12/11.
//  Copyright 2011 Mogreet Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController <UITextFieldDelegate> {
    IBOutlet UIButton *buttonLook;
    IBOutlet UILabel *campidLook;
    IBOutlet UITextField *clientLook;
    IBOutlet UILabel *contentidLook;
    IBOutlet UILabel *eventLook;
    IBOutlet UILabel *fromNameLook;
    IBOutlet UILabel *fromNumLook;
    IBOutlet UITextField *hashLook;
    IBOutlet UILabel *messLook;
    IBOutlet UITextField *messidLook;
    IBOutlet UILabel *respCodeLook;
    IBOutlet UILabel *respStatusLook;
    IBOutlet UILabel *statusLook;
    IBOutlet UILabel *toNameLook;
    IBOutlet UILabel *toNumLook;
    IBOutlet UITextField *tokenLook;
}
- (IBAction)validateLookup:(id)sender;
@end
