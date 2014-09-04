//
//  GameViewController.h
//  UltimateTicTacToe
//
//  Created by Franklin Totten on 6/9/14.
//
//

#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "GameBoard.h"
#import "GCTurnBasedMatchHelper.h"
#import "CustomButton.h"

@protocol GameNavigationHandler <NSObject>
- (void)moveGameToHome;
@end

@interface GameView : UIView <BaseViewDelegate, GCTurnBasedMatchHelperDelegate> {
    IBOutlet UIView* baseOutline;
//    IBOutlet UIView* gameView;
    BaseView* baseView;
    GameBoard* gameBoard;
    int size;
    int previousBorder;
    BOOL isMyTurn;
    IBOutlet CustomButton* bNewGame;
    IBOutlet CustomButton* bSelect;
    IBOutlet UIButton* back;
    id <GameNavigationHandler> navHandler;
}
@property (nonatomic, retain) IBOutlet CustomButton* bSelect;
@property (nonatomic, retain) IBOutlet CustomButton* bNewGame;
@property (nonatomic, retain) IBOutlet UIView* baseOutline;
//@property (nonatomic, retain) IBOutlet UIView* gameView;
@property (nonatomic, retain) BaseView* baseView;
@property (nonatomic, retain) GameBoard* gameBoard;
@property (nonatomic, retain) id <GameNavigationHandler> navHandler;


- (IBAction)newGame;
- (IBAction)select;
- (IBAction)back;
- (void)reloadColors;
- (void)loadView;

@end
