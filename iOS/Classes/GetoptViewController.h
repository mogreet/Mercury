//
//  GetoptViewController.h
//  Mercury_iOS
//
//  Created by Julien Salvi on 9/12/11.
//  Copyright 2011 Mogreet Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GetoptViewController : UIViewController <UITextFieldDelegate> {
    IBOutlet UIButton *buttonGetopt;
    IBOutlet UILabel *campStatusCodeGetopt;
    IBOutlet UILabel *campStatusGetopt;
    IBOutlet UITextField *campidGetopt;
    IBOutlet UITextField *clientGetopt;
    IBOutlet UILabel *messGetopt;
    IBOutlet UITextField *numGetopt;
    IBOutlet UILabel *respCodeGetopt;
    IBOutlet UILabel *respStatusGetopt;
    IBOutlet UITextField *tokenGetopt;
}
- (IBAction)validateGetopt:(id)sender;
@end
