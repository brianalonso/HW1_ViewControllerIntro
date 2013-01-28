//
//  BDATransitionViewController.m
//  HW1_ViewControllerIntro
//
//  Created by Brian Alonso on 1/24/13.
//  Copyright (c) 2013 Brian Alonso. All rights reserved.
//

#import "BDATransitionViewController.h"

@interface BDATransitionViewController ()

// Private properties/Outlets
@property (weak, nonatomic) IBOutlet UIButton *buttonDismissText;

@end

@implementation BDATransitionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    // Set the button text from the public property
    [[self buttonDismissText] setTitle:self.buttonText forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    // Dismiss this viewcontroller
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:[self dismissBlock]];
    
}

- (IBAction)buttonClicked:(UIButton *)sender {
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:[self dismissBlock]];
}
@end
