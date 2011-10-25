//
//  SetoptViewController.h
//  Mercury_iOS
//
//  Created by Julien Salvi on 9/12/11.
//  Copyright 2011 Mogreet Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetoptViewController : UIViewController <UITextFieldDelegate> {
    IBOutlet UIButton *buttonSetopt;
    IBOutlet UITextField *campStatusCodeSetopt;
    IBOutlet UITextField *campidSetopt;
    IBOutlet UITextField *clientSetopt;
    IBOutlet UILabel *messSetopt;
    IBOutlet UITextField *numSetopt;
    IBOutlet UILabel *respCodeSetopt;
    IBOutlet UILabel *respStatusSetopt;
    IBOutlet UITextField *tokenSetopt;
    IBOutlet UILabel *campIDSet;
    IBOutlet UILabel *campStatusSetopt;
    IBOutlet UILabel *statusCodeSetopt;
}

- (IBAction)validateSetopt:(id)sender;

@end
