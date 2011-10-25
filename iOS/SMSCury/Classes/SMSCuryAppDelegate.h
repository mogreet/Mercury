//
//  SMSCuryAppDelegate.h
//  SMSCury
//
//  Created by Julien Salvi on 9/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMSCuryViewController;

@interface SMSCuryAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SMSCuryViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SMSCuryViewController *viewController;

@end

