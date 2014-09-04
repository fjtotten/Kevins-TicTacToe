//
//  GameBoard.m
//  UltimateTicTacToe
//
//  Created by Franklin Totten on 11/18/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "GameBoard.h"

@implementation GameBoard
@synthesize boardData;
@synthesize turn;
@synthesize winners;
@synthesize winner;
@synthesize winningPositions;

- (id)initWithData:(NSData *)data {
    self = [super init];
    if (self) {
        NSString* dataStr = [NSString stringWithUTF8String:[data bytes]];
        int pos = 0;

        if (dataStr == nil || [dataStr length] == 0) {
            size = 3;
        } else {
            size = [dataStr characterAtIndex:pos++]-'0';
        }

        if ([dataStr length] != 4 + size*size*size*size + size*size+1 + size*size+1) {
            self = [self initWithSize:size];
            return self;
        }
        previousBoard = -1;
        previousPos = -1;
        currentBoard = -1;
        currentPos = -1;
        
        self.winner = [NSString stringWithFormat:@"%C", [dataStr characterAtIndex:pos++]];
        self.turn = [NSString stringWithFormat:@"%C", [dataStr characterAtIndex:pos++]];
        enabledBoard = [dataStr characterAtIndex:pos++]-'0';
//        self.winner = [NSString stringWithUTF8String:&(dataChars[pos++])];
//        self.turn = [NSString stringWithUTF8String:&(dataChars[pos++])];
        self.boardData = [[NSMutableArray alloc] init];
        for (int i = 0; i < size*size; i++) {
            NSMutableArray* board = [[NSMutableArray alloc] init];
            for (int j = 0; j<size*size; j++) {
                [board addObject:[NSString stringWithFormat:@"%C", [dataStr characterAtIndex:pos++]]];
//                [board addObject:[NSString stringWithUTF8String:&(dataChars[pos++])]];
            }
            [self.boardData addObject:board];
        }
        
        self.winners = [[NSMutableArray alloc] init];
        for (int i = 0; i < size*size+1; i++) {
            [self.winners addObject:[NSString stringWithFormat:@"%C", [dataStr characterAtIndex:pos++]]];
//            [self.winners addObject:[NSString stringWithUTF8String:&(dataChars[pos++])]];
        }
        
        self.winningPositions = [[NSMutableArray alloc] init];
        for (int i = 0; i < size*size+1; i++) {
            [self.winningPositions addObject:[NSString stringWithFormat:@"%C", [dataStr characterAtIndex:pos++]]];
//            [self.winningPositions addObject:[NSString stringWithFormat:@"%c", dataChars[pos++]]];
        }
    }
    return self;
}

- (NSData*)exportData {
    NSMutableString* str = [[NSMutableString alloc] init];
    [str appendString:[NSString stringWithFormat:@"%i", size]];
    [str appendString:self.winner];
    [str appendString:self.turn];
    [str appendString:[NSString stringWithFormat:@"%C", (unichar)(enabledBoard+'0')]];
    for (int i = 0; i < self.boardData.count; i++) {
        NSArray* board = [self.boardData objectAtIndex:i];
        for (int j = 0; j < board.count; j++) {
            [str appendString:[board objectAtIndex:j]];
        }
    }
    for (int i = 0; i < self.winners.count; i++) {
        [str appendString:[self.winners objectAtIndex:i]];
    }
    for (int i = 0; i < self.winningPositions.count; i++) {
        [str appendString:[self.winningPositions objectAtIndex:i]];
    }
    return [str dataUsingEncoding:NSUTF8StringEncoding];
}

- (id)initWithSize:(int)s {
    self = [super init];
    if (self) {
        size = s;
        previousBoard = -1;
        previousPos = -1;
        currentBoard = -1;
        currentPos = -1;
        enabledBoard = size*size;
        self.winner = @" ";
        [self setTurn:@"X"];
        self.boardData = [[NSMutableArray alloc] init];
        for (int i = 0; i < size*size; i++) {
            NSMutableArray* board = [[NSMutableArray alloc] init];
            for (int j = 0; j<size*size; j++) {
                [board addObject:@" "];
            }
            [self.boardData addObject:board];
        }
        self.winners = [[NSMutableArray alloc] init];
        self.winningPositions = [[NSMutableArray alloc] init];
        for (int i = 0; i < size*size+1; i++) {
            [self.winners addObject:@" "];
            [self.winningPositions addObject:@" "];
        }
    }
    return self;
}

- (void)reset {
    previousBoard = -1;
    previousPos = -1;
    currentBoard = -1;
    currentPos = -1;
    enabledBoard = size*size;
    self.winner = @" ";
    [self setTurn:@"X"];
    for (int i = 0; i < size*size; i++) {
        for (int j = 0; j<size*size; j++) {
            [[self.boardData objectAtIndex:i] replaceObjectAtIndex:j withObject:@" "];
        }
    }
    for (int i = 0; i < size*size+1; i++) {
        [self.winners replaceObjectAtIndex:i withObject:@" "];
        [self.winningPositions replaceObjectAtIndex:i withObject:@" "];
    }
}

// Board and Pos must be valid values
// Returns TRUE to signal removing previous image (change in position)
- (BOOL)touchAtBoard:(int)board position:(int)pos {
    // set tracking
    if (board!=currentBoard || pos!=previousPos) {
        previousPos = currentPos;
        previousBoard = currentBoard;
        currentPos = pos;
        currentBoard = board;
        return TRUE;
    } else {
        return FALSE;
    }
}

- (void)touchOutside {
    // unset tracking
    previousPos = currentPos;
    previousBoard = currentBoard;
    currentPos = -1;
    currentBoard = -1;
}

- (BOOL)selectAtBoard:(int)board position:(int)pos {
    [[self.boardData objectAtIndex:board] replaceObjectAtIndex:pos withObject:[self.turn copy]];
    int winnerVal = [self processWinner:board];
    if (winnerVal >= 0) {
        if ([self processWinner:size*size]) {
            [self gameOver];
        }
    }
    previousPos = currentPos;
    previousBoard = currentBoard;
    currentPos = -1;
    previousPos = -1;
    if ([self.winner isEqualToString:@" "]) {
        [self setEnabledBoard:pos];
    }
    return previousBoard != board || previousPos != pos;
}
         
- (BOOL)valueNotSetForBoard:(int)board position:(int)pos {
    return [[[self.boardData objectAtIndex:board] objectAtIndex:pos] isEqualToString:@" "];
}

- (BOOL) validBoard:(int)board position:(int)pos {
    if (enabledBoard < size*size && enabledBoard != board) {
        return FALSE;
    } else {
        return board >= 0 && board < size*size && pos >= 0 && pos < size*size;
    }
}

- (void)setEnabledBoard:(int)board {
    NSArray* data = [self.boardData objectAtIndex:board];
    for (int i = 0; i < data.count; i++) {
        if ([[data objectAtIndex:i] isEqualToString:@" "]) {
            enabledBoard = board;
            return;
        }
    }
    enabledBoard = size*size;
}

- (int)enabledBoard {
    return enabledBoard;
}

- (BOOL)winnerForBoard:(int)board player:(NSString *)xo {
    if (board < 0) {
        return FALSE;
    }
    return [xo isEqualToString:[self.winners objectAtIndex:board]];
}

- (void)switchTurn {
    if ([self.turn isEqualToString:@"X"])
        [self setTurn:@"O"];
    else
        [self setTurn:@"X"];
}

- (int)currentBoard {
    return currentBoard;
}

- (int)currentPos {
    return currentPos;
}

- (int)previousBoard {
    return previousBoard;
}

- (int)previousPosition {
    return previousPos;
}

- (BOOL)processWinner:(int)board {
    BOOL winnerExists;
    NSArray* data;
    if (board == size*size) {
        data = self.winners;
    } else {
        data = [self.boardData objectAtIndex:board];
    }
    for (int i = 0 ; i < size; i++) {
        // horizontals
        winnerExists = TRUE;
        for (int j = 0; j < size; j++) {
            if (![self.turn isEqualToString:[data objectAtIndex:(i*size+j)]]) {
                winnerExists = FALSE;
                break;
            }
        }
        if (winnerExists) {
            [self.winners replaceObjectAtIndex:board withObject:[self turn]];
            [self.winningPositions replaceObjectAtIndex:board 
                                             withObject:[NSString stringWithFormat:@"%i", i]];
            return winnerExists;
        }
        
        // verticals
        winnerExists = TRUE;
        for (int j = 0; j < size; j++) {
            if (![self.turn isEqualToString:[data objectAtIndex:(i+j*size)]]) {
                winnerExists = FALSE;
                break;
            }
        }
        
        if (winnerExists) {
            [self.winners replaceObjectAtIndex:board withObject:[self turn]];
            [self.winningPositions replaceObjectAtIndex:board 
                                             withObject:[NSString stringWithFormat:@"%i", i+size]];
            return winnerExists;
        }
    }
    
    // diagonals
    winnerExists = TRUE;
    for (int i = 0; i < size; i++) {
        if (![self.turn isEqualToString:[data objectAtIndex:(i*size+i)]]) {
            winnerExists = FALSE;
            break;
        }
    }
    if (winnerExists) {
        [self.winners replaceObjectAtIndex:board withObject:[self turn]];
        [self.winningPositions replaceObjectAtIndex:board 
                                         withObject:[NSString stringWithFormat:@"%i", 2*size]];
        return winnerExists;
    }
    winnerExists = TRUE;
    for (int i = 0; i < size; i++) {
        if (![self.turn isEqualToString:[data objectAtIndex:(i*size+size-i-1)]]) {
            winnerExists = FALSE;
            break;
        }
    }
    if (winnerExists) {
        [self.winners replaceObjectAtIndex:board withObject:[self turn]];
        [self.winningPositions replaceObjectAtIndex:board 
                                         withObject:[NSString stringWithFormat:@"%i", 2*size+1]];
        return winnerExists;
    }
    return winnerExists;
}

- (int)getSize {
    return size;
}

- (void)gameOver {
    enabledBoard = size*size;
    self.winner = [self turn];
}



@end
