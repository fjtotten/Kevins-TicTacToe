//
//  GCTurnBasedMatchHelper.h
//  UltimateTicTacToe
//
//  Created by Franklin Totten on 6/14/14.
//
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@protocol GCTurnBasedMatchHelperDelegate
- (void)enterNewGame:(GKTurnBasedMatch*)match;
- (void)layoutMatch:(GKTurnBasedMatch*)match;
- (void)takeTurn:(GKTurnBasedMatch*)match;
- (void)recieveEndGame:(GKTurnBasedMatch*)match;
- (void)sendNotice:(NSString*)notice forMatch:(GKTurnBasedMatch*)match;
@end

@protocol GCTurnBasedMatchHandlerDelegate
- (void)startTurn;
@end

@interface GCTurnBasedMatchHelper : NSObject <GKTurnBasedMatchmakerViewControllerDelegate, GKTurnBasedEventHandlerDelegate> {
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
    UIViewController* presentingViewController;
    
    GKTurnBasedMatch* currentMatch;
    
    id <GCTurnBasedMatchHelperDelegate> delegate;
    id <GCTurnBasedMatchHandlerDelegate> handler;
}

@property (assign, readonly) BOOL gameCenterAvailable;
@property (retain) GKTurnBasedMatch* currentMatch;
@property (nonatomic, retain) id <GCTurnBasedMatchHelperDelegate> delegate;
@property (nonatomic, retain) id <GCTurnBasedMatchHandlerDelegate> handler;

+ (GCTurnBasedMatchHelper *)sharedInstance;
- (void)authenticateLocalUser;
- (void)authenticationChanged;
- (void)findMatchWithMinPlayers:(int)minPlayers maxPlayers:(int)maxPlayers
                 viewController:(UIViewController*)viewController;

@end

