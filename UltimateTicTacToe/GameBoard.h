//
//  GameBoard.h
//  UltimateTicTacToe
//
//  Created by Franklin Totten on 11/18/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameBoard : NSObject {
    int size;
    int previousBoard;
    int previousPos;
    int currentBoard;
    int currentPos;
    int enabledBoard;
    NSString* winner;
    NSMutableArray* boardData;
    NSString* turn;
    NSMutableArray* winners;
    NSMutableArray* winningPositions;
}
@property(nonatomic, retain) NSMutableArray* boardData;
@property(nonatomic, retain) NSString* turn;
@property(nonatomic, retain) NSMutableArray* winners;
@property(nonatomic, retain) NSString* winner;
@property(nonatomic, retain) NSMutableArray* winningPositions;

- (id)initWithSize:(int)size;
- (id)initWithData:(NSData*)data;
- (int)previousBoard;
- (int)previousPosition;
- (int)currentBoard;
- (int)currentPos;
- (int)enabledBoard;
- (void)switchTurn;
- (int)getSize;
- (NSData*)exportData;

- (BOOL)validBoard:(int)board position:(int)pos;
- (BOOL)touchAtBoard:(int)board position:(int)pos;
- (void)touchOutside;
- (BOOL)selectAtBoard:(int)board position:(int)pos;
- (BOOL)valueNotSetForBoard:(int)board position:(int)pos;
- (BOOL)winnerForBoard:(int)board player:(NSString*)xo;
- (void)reset;


@end
