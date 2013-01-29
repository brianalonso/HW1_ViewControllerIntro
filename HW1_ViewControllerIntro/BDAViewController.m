//
//  BDAViewController.m
//  HW1_ViewControllerIntro
//
//  Created by Brian Alonso on 1/18/13.
//  Copyright (c) 2013 Brian Alonso. All rights reserved.
//

#import "BDAViewController.h"
#import "BDATransitionViewController.h"

@interface BDAViewController ()

// Private Outlets/Properties
@property (weak, nonatomic) IBOutlet UILabel *lblCoverVertical;
@property (weak, nonatomic) IBOutlet UILabel *lblFlipHorizontal;
@property (weak, nonatomic) IBOutlet UILabel *lblCrossDisolve;

@property (weak, nonatomic) IBOutlet UILabel *lblPartialCurl;
@property (weak, nonatomic) IBOutlet UIButton *showMoreButton;

@property (assign, nonatomic) NSInteger coverVertical;
@property (assign, nonatomic) NSInteger flipHorizontal;
@property (assign, nonatomic) NSInteger crossDissolve;
@property (assign, nonatomic) NSInteger partialCurl;
@property (strong, nonatomic) BDATransitionViewController *transitionController;

// Private Actions
- (IBAction)buttonPressed:(UIButton *)sender;

@end

@implementation BDAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Experiment with custom buttons
	UIImage *buttonImageNormal = [UIImage imageNamed:@"whiteButton.png"];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 12, 0, 12);
    UIImage *stretchableButtonImageNormal = [buttonImageNormal
                                             resizableImageWithCapInsets:insets];
    [self.showMoreButton setBackgroundImage:stretchableButtonImageNormal
                                      forState:UIControlStateNormal];
    
    UIImage *buttonImagePressed = [UIImage imageNamed:@"blueButton.png"];
    UIImage *stretchableButtonImagePressed = [buttonImagePressed
                                              resizableImageWithCapInsets:insets];
    [self.showMoreButton setBackgroundImage:stretchableButtonImagePressed
                                      forState:UIControlStateHighlighted];
    // Initialize counts
    self.coverVertical = 0;
    self.flipHorizontal = 0;
    self.crossDissolve = 0;
    self.partialCurl = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of the transition view controller we have stuffed in a property
    self.transitionController= nil;
}

// Supported Autorotations
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscape;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)buttonPressed:(UIButton *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Which Modal Transition Style?"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:@"Destroy!"
                                  otherButtonTitles:@"Cover Vertical", @"Flip Horizontal", @"Cross Disolve", @"Partial Curl", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    DLog(@"Button Index: %d", buttonIndex);
    if (buttonIndex != [actionSheet cancelButtonIndex])
    {
        // Instantiate view if nil (Lazy load)
        if (self.transitionController == nil) {
            self.transitionController = [[BDATransitionViewController alloc]                            initWithNibName:@"BDATransitionViewController"                                                                                                 bundle:nil];
            
            [self.transitionController setDismissBlock:^{
                NSLog(@"Dismiss complete");
            }];
        }
        
        switch (buttonIndex) {
            case 0: // Destroy
                DLog(@"Destroy button pressed");
                break;

            case 1: // Cover Vertical
                self.coverVertical ++;
                self.lblCoverVertical.text = [NSString stringWithFormat:@"Cover Vertical:  %i", [self coverVertical]];
                DLog(@"Cover Vertical button pressed: %i", [self coverVertical]);
                [self.transitionController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
                self.transitionController.buttonText = @"Dismiss Cover Vertical";
                break;
                
            case 2: // Flip Horizontal
                self.flipHorizontal ++;
                self.lblFlipHorizontal.text = [NSString stringWithFormat:@"Flip Horizontal:  %i", [self flipHorizontal]];
                DLog(@"Flip Horizontal button pressed: %i", [self flipHorizontal]);
                [self.transitionController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
                self.transitionController.buttonText = @"Dismiss Flip Horizonal";
                break;
                
            case 3: // Cross Dissolve
                self.crossDissolve ++;
                self.lblCrossDisolve.text = [NSString stringWithFormat:@"Cross Dissolve:  %i", [self crossDissolve]];
                DLog(@"Cross Dissolve button pressed: %i", [self crossDissolve]);
                [self.transitionController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
                self.transitionController.buttonText = @"Dismiss Cross Disolve";
                break;
                
            case 4: // Partial Curl
                self.partialCurl ++;
                self.lblPartialCurl.text = [NSString stringWithFormat:@"Partial Curl:  %i", [self partialCurl]];
                DLog(@"Partial Curl button pressed: %i", [self partialCurl]);
                [self.transitionController setModalTransitionStyle:UIViewAnimationTransitionCurlUp];
                
                self.transitionController.buttonText = @"Dismiss Partial Curl";
                break;
                
            default:
                break;
        }
        
        // Display the view if any button other than Destroy is pressed
        if (buttonIndex == 0) {
            alert = [[UIAlertView alloc]
                    initWithTitle:@"Really Destroy?"
                    message:@"This will destroy everything."
                    delegate:self
                    cancelButtonTitle:@"No"
                    otherButtonTitles:@"Yes", nil];
            [alert show];
        }
        else {
            // Present the view
            [self presentViewController:self.transitionController animated:YES completion:^{}];
        }        
    }
    else
        // Cancel
        DLog(@"Cancel button pressed");

}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    [[self transitionController] dismissViewControllerAnimated:YES completion:completion];
}

- (void)dismissUsageAlert
{
    [alert dismissWithClickedButtonIndex:-1 animated:YES];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //Process Alertview button click
    switch (buttonIndex) {
        case 1:
            // Yes
            //Change the background view color to red
            self.view.backgroundColor = [UIColor redColor];
            break;
            
        default:
            // Default
            //Change the background view color back to gray
            self.view.backgroundColor = [UIColor lightGrayColor];
            break;
    }
}


@end
