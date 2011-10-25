//
//  UncacheViewController.h
//  Mercury_iOS
//
//  Created by Julien Salvi on 9/12/11.
//  Copyright 2011 Mogreet Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UncacheViewController : UIViewController <UITextFieldDelegate> {
    IBOutlet UIButton *buttonUncache;
    IBOutlet UITextField *clientUncache;
    IBOutlet UILabel *messUncache;
    IBOutlet UITextField *numUncache;
    IBOutlet UILabel *numberUncache;
    IBOutlet UILabel *respCodeUncache;
    IBOutlet UILabel *respStatusUncache;
    IBOutlet UITextField *tokenUncache;
}
- (IBAction)validateUncache:(id)sender;
@end
