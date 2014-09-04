//
//  BaseView.m
//  UltimateTicTacToe
//
//  Created by Franklin Totten on 11/16/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView
@synthesize bigBoard;
@synthesize smallBoards;
@synthesize winnerView;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        UIImageView* background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//        [background setImage:[UIImage imageNamed:@"board_background.jpg"]];
//        [background setBackgroundColor:[UIColor clearColor]];
//        [self addSubview:background];
        self.bigBoard = nil;
        self.smallBoards = [[NSMutableArray alloc] init];
        self.winnerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    return self;
}

- (void)reset {
    for (int i = 0; i < self.smallBoards.count; i++) {
        [[self.smallBoards objectAtIndex:i] reset];
    }
    [self.winnerView removeFromSuperview];
}

- (void)reloadColors {
    for (BoardView* smallBoard in self.smallBoards) {
        [smallBoard reloadPieceColors];
        [smallBoard reloadBarColors];
    }
    [self.bigBoard reloadBarColors];
}

- (void)addBigBoard:(BoardView *)board {
    if ([self bigBoard])
        [self.bigBoard removeFromSuperview];
    [self setBigBoard:board];
    [self addSubview:board];
}

- (void)addSmallBoard:(BoardView*)board {
    [self.smallBoards addObject:board];
    [self addSubview:board];
}


- (void)addXAtBoard:(int)boardPos position:(int)pos light:(BOOL)light {
    [[self.smallBoards objectAtIndex:boardPos] addXAt:pos light:light];
}

- (void)addOAtBoard:(int)boardPos position:(int)pos light:(BOOL)light {
    [[self.smallBoards objectAtIndex:boardPos] addOAt:pos light:light];
}

- (void)addBigX:(int)board {
    [[self.smallBoards objectAtIndex:board] addBigX];
}

- (void)addBigO:(int)board {
    [[self.smallBoards objectAtIndex:board] addBigO];
}

- (void)removeXOAtBoard:(int)boardPos position:(int)pos {
    [[self.smallBoards objectAtIndex:boardPos] removeXOAt:pos];
}

- (void)addWinnerLine:(int)board position:(int)position {
    [[self.smallBoards objectAtIndex:board] addWinnerLine:position];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    int board = [self inBoard:[touches.anyObject locationInView:self]];
    int pos = -1;
    if (board >= 0)
        pos = [[self.smallBoards objectAtIndex:board] inBox:[touches.anyObject locationInView:self]];
    [self.delegate touchBeganInBoard:board atPosition:pos];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    int board = [self inBoard:[touches.anyObject locationInView:self]];
    int pos = -1;
    if (board >= 0)
        pos = [[self.smallBoards objectAtIndex:board] inBox:[touches.anyObject locationInView:self]];
    [self.delegate touchMovedInBoard:board atPosition:pos];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    int board = [self inBoard:[touches.anyObject locationInView:self]];
    int pos = -1;
    if (board >= 0)
        pos = [[self.smallBoards objectAtIndex:board] inBox:[touches.anyObject locationInView:self]];
    if (pos >=0) {
        [self.delegate touchEndedInBoard:board atPosition:pos];
    }
}

- (void)setActiveBoard:(int)board {
    if (board >= 0 && board < self.smallBoards.count) {
        for (int i = 0; i < self.smallBoards.count; i++) {
            if (i == board) {
                [self.smallBoards[i] setActive:TRUE];
            } else {
                [self.smallBoards[i] setActive:FALSE];
            }
        }
    } else {
        for (BoardView* board in self.smallBoards) {
            [board setAlpha:1.0];
        }
    }
}

//- (void)moveBorderFrom:(int)boardFrom to:(int)boardTo {
//    if (boardFrom >= 0 && boardFrom < self.smallBoards.count) {
//        [[self.smallBoards objectAtIndex:boardFrom] removeBorder];
//    }
//    if (boardTo >= 0 && boardTo < self.smallBoards.count) {
//        [[self.smallBoards objectAtIndex:boardTo] addBorder];
//    }
//}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.delegate touchCancelled];
}

- (int)inBoard:(CGPoint)touch {
    for (int i = 0; i < [self.smallBoards count]; i++) {
        if ([[self.smallBoards objectAtIndex:i] pointInside:touch]) {
            return i;
        }
    }
    return -1;
}

- (void)showWinner:(NSString *)winner {
    if ([winner isEqualToString:@"X"]) {
        [self.winnerView setImage:[UIImage imageNamed:@"X.png"]];
    } else if ([winner isEqualToString:@"O"]) {
        [self.winnerView setImage:[UIImage imageNamed:@"O.png"]];
    }
    [self.winnerView setAlpha:0.7];
    [self addSubview:self.winnerView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
