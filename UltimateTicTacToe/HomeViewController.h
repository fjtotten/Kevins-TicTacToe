//
//  HomeViewController.h
//  UltimateTicTacToe
//
//  Created by Franklin Totten on 12/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface HomeViewController : UIViewController <UIActionSheetDelegate, GKTurnBasedMatchmakerViewControllerDelegate, GKMatchDelegate> {
    IBOutlet UILabel* label;
    int count;
//    GameCenterManager* gameCenterManager;
    GKMatch* myMatch;
    BOOL matchStarted;
}
@property (nonatomic, retain) IBOutlet UILabel* label;
//@property (nonatomic, retain) GameCenterManager* gameCenterManager;
@property (nonatomic, retain) GKMatch* myMatch;
@property (nonatomic) BOOL matchStarted;

- (IBAction)goToNext;
- (IBAction)writeToFile:(id)sender;
- (IBAction)readFromFile:(id)sender;
- (IBAction)findMatch:(id)sender;

@end
