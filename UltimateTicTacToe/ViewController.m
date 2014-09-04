//
//  ViewController.m
//  UltimateTicTacToe
//
//  Created by Franklin Totten on 11/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
//@synthesize match;
@synthesize homeView;
@synthesize gameView;
@synthesize settingsView;
@synthesize backgroundView;

//- (void)viewWillAppear:(BOOL)animated {
//    [self setBackgroundImage];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    appDelegate.backgroundDelegate = self;
    [self setBackgroundImage];
    [GCTurnBasedMatchHelper sharedInstance].handler = self;
    size = 3;
    gameView.navHandler = self;
    settingsView.navHandler = self;

}

- (IBAction)showGame:(id)sender {
    [self startTurn];
}

- (void)startTurn {
    [self.gameView reloadColors];
    [self.gameView.baseView setNeedsDisplay];
    [self.gameView loadView];
    [self.homeView setFrame:CGRectMake(-320, 0, 320, 568)];
    [self.gameView setFrame:CGRectMake(0, 0, 320, 568)];
}

- (void)loadBackgroundImage {
    [self setBackgroundImage];
}

- (void)moveGameToHome {
    [self.homeView setFrame:CGRectMake(0, 0, 320, 568)];
    [self.gameView setFrame:CGRectMake(320, 0, 320, 568)];
}

- (void)moveSettingsToHome {
    [self.homeView setFrame:CGRectMake(0, 0, 320, 568)];
    [self.settingsView setFrame:CGRectMake(-320, 0, 320, 568)];
}

- (void)presentImagePicker:(UIImagePickerController *)picker animated:(BOOL)animated {
    [self presentModalViewController:picker animated:animated];
}

- (void)setBackgroundImage {
    UIImage* image = [[UIImage alloc] initWithContentsOfFile:getBackgroundFilePath()];
    [self.backgroundView setImage:image];
}

- (IBAction)showSettings:(id)sender {
    [self.settingsView loadView];
    [self.homeView setFrame:CGRectMake(320, 0, 320, 568)];
    [self.settingsView setFrame:CGRectMake(0, 0, 320, 568)];
}


- (void) showAlertWithTitle: (NSString*) title message: (NSString*) message
{
	UIAlertView* alert= [[UIAlertView alloc] 
                         initWithTitle: title message: message 
                         delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL];
	[alert show];
}

- (IBAction)findMatch:(id)sender
{
    [[GCTurnBasedMatchHelper sharedInstance] findMatchWithMinPlayers:2 maxPlayers:2 viewController:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
