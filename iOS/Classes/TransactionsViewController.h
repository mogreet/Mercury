//
//  TransactionsViewController.h
//  Mercury_iOS
//
//  Created by Julien Salvi on 9/12/11.
//  Copyright 2011 Mogreet Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TransactionsViewController : UIViewController <UITextFieldDelegate> {
    IBOutlet UIButton *buttonTrans;
    IBOutlet UITextField *clientTrans;
    IBOutlet UILabel *messTrans;
    IBOutlet UITextField *numTrans;
    IBOutlet UILabel *respCodeTrans;
    IBOutlet UILabel *respStatusTrans;
    IBOutlet UITextField *tokenTrans;
    IBOutlet UILabel *campNameTrans;
    IBOutlet UILabel *campidTrans;
    IBOutlet UILabel *fromTrans;
    IBOutlet UILabel *hashTrans;
    IBOutlet UILabel *messidTrans;
    IBOutlet UILabel *toTrans;
}
- (IBAction)validateTrans:(id)sender;
@end
