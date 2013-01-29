//
//  BDATransitionViewController.h
//  HW1_ViewControllerIntro
//
//  Created by Brian Alonso on 1/24/13.
//  Copyright (c) 2013 Brian Alonso. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDATransitionViewController : UIViewController

// Actions
- (IBAction)buttonClicked:(UIButton *)sender;

// Public properties set by presenting controller
@property (nonatomic, copy) void (^dismissBlock)(void);

@property (copy, nonatomic) NSString *buttonText;
@end
