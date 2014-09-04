//
//  ViewController.h
//  UltimateTicTacToe
//
//  Created by Franklin Totten on 11/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sys/time.h>
#import "AppDelegate.h"
#import "GameBoard.h"
#import "GameView.h"
#import "HomeView.h"
#import "GCTurnBasedMatchHelper.h"
#import "SettingsView.h"
#import "Common.h"

@interface ViewController : UIViewController <UIActionSheetDelegate, GCTurnBasedMatchHandlerDelegate, GameNavigationHandler, SettingsNavigationHandler, BackgroundInitDelegate> {
    int size;
    IBOutlet HomeView* homeView;
    IBOutlet GameView* gameView;
    IBOutlet SettingsView* settingsView;
    IBOutlet UIImageView* backgroundView;
}

@property (nonatomic, retain) IBOutlet HomeView* homeView;
@property (nonatomic, retain) IBOutlet GameView* gameView;
@property (nonatomic, retain) IBOutlet SettingsView* settingsView;
@property (nonatomic, retain) IBOutlet UIImageView* backgroundView;

- (IBAction)showGame:(id)sender;
- (IBAction)findMatch:(id)sender;
- (IBAction)showSettings:(id)sender;

@end
