//
//  BaseView.h
//  UltimateTicTacToe
//
//  Created by Franklin Totten on 11/16/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoardView.h"

@class BaseView;
@protocol BaseViewDelegate <NSObject>
- (void)touchBeganInBoard:(int)board atPosition:(int)pos;
- (void)touchMovedInBoard:(int)board atPosition:(int)pos;
- (void)touchEndedInBoard:(int)board atPosition:(int)pos;
- (void)touchCancelled;
@end

@interface BaseView : UIView {
    BoardView* bigBoard;
    NSMutableArray* smallBoards;
    UIImageView* winnerView;
}
@property(nonatomic, retain) BoardView* bigBoard;
@property(nonatomic, retain) NSMutableArray* smallBoards;
@property(nonatomic, retain) UIImageView* winnerView;
@property(nonatomic, weak) id <BaseViewDelegate> delegate;

- (void)addBigBoard:(BoardView*)board;
- (void)addSmallBoard:(BoardView*)board;
- (void)addXAtBoard:(int)boardPos position:(int)pos light:(BOOL)light;
- (void)addOAtBoard:(int)boardPos position:(int)pos light:(BOOL)light;
- (void)addBigX:(int)board;
- (void)addBigO:(int)board;
- (void)removeXOAtBoard:(int)boardPos position:(int)pos;
- (void)setActiveBoard:(int)board;
//- (void)moveBorderFrom:(int)boardFrom to:(int)boardTo;
- (void)showWinner:(NSString*)winner;
- (void)addWinnerLine:(int)board position:(int)position;
- (void)reset;
- (void)reloadColors;
                    

@end
