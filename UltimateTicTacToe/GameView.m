//
//  GameViewController.m
//  UltimateTicTacToe
//
//  Created by Franklin Totten on 6/9/14.
//
//

#import "GameView.h"

@interface GameView ()

@end

@implementation GameView
@synthesize bSelect;
@synthesize baseOutline;
@synthesize bNewGame;
@synthesize baseView;
@synthesize navHandler;
@synthesize gameBoard;

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {

    }
    return self;
}

- (void)loadView
{
    int buffer = 15;
    size = 3;
    [GCTurnBasedMatchHelper sharedInstance].delegate = self;
    
    if ([[GCTurnBasedMatchHelper sharedInstance] currentMatch] && [[GCTurnBasedMatchHelper sharedInstance].currentMatch.matchData length] > 0) {
        [self setGameBoard:[[GameBoard alloc] initWithData:[[GCTurnBasedMatchHelper sharedInstance].currentMatch matchData]]];
    } else {
        [self setGameBoard:[[GameBoard alloc] initWithSize:size]];
    }
    
    [self setBaseView:[[BaseView alloc] initWithFrame:CGRectMake(0, 0, self.baseOutline.frame.size.width, self.baseOutline.frame.size.height)]];
    [self.baseOutline addSubview:self.baseView];
    
    int bigWidth = baseView.frame.size.width-(2*buffer);
    int bigHeight = baseView.frame.size.height-(2*buffer);
    BoardView* bigBoard = [[BoardView alloc] initWithFramePlus:CGRectMake(buffer, buffer, bigWidth, bigHeight)
                                                          size:size position:0 width:bigWidth/40];
    
    [self.baseView addBigBoard:bigBoard];
    [self.baseView setDelegate:self];
    
    int smallBuf = 4;
    int smallWidth = bigBoard.frame.size.width/size-(2*smallBuf);
    int smallHeight = bigBoard.frame.size.height/size-(2*smallBuf);
    
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            BoardView* smallBoard = [[BoardView alloc] initWithFramePlus:CGRectMake(buffer+(bigBoard.frame.size.width*j)/size+smallBuf, buffer+(bigBoard.frame.size.height*i)/size+smallBuf, smallWidth, smallHeight) size:size position:i*size+j width:smallWidth / 14];
            [self.baseView addSmallBoard:smallBoard];
        }
    }
    
    [self matchViewToGame];
    
    [bSelect setCustom:TRUE];
    
}

- (IBAction)back {
    [self.navHandler moveGameToHome];
}

- (IBAction)newGame {
    [self.gameBoard reset];
    [self.baseView reset];
}

- (IBAction)select {
    int board = [self.gameBoard currentBoard];
    int pos = [self.gameBoard currentPos];
    previousBorder = [self.gameBoard enabledBoard];
    BOOL winnerNotFound = ![self.gameBoard winnerForBoard:board player:@"X"] &&
    ![self.gameBoard winnerForBoard:board player:@"O"];
    
    if (![self.gameBoard validBoard:board position:pos] || ![self.gameBoard valueNotSetForBoard:board position:pos]) {
        [self.gameBoard touchOutside];
        [self removeLastImage];
        return;
    } else if ([self.gameBoard selectAtBoard:board position:pos]) {
        [self removeLastImage];
    }
    
    int winningPosition = [[self.gameBoard.winningPositions objectAtIndex:board] intValue];
    
    if ([self.gameBoard.turn isEqualToString:@"X"]) {
        [self.baseView addXAtBoard:board position:pos light:!winnerNotFound];
        if (winnerNotFound && [self.gameBoard winnerForBoard:board player:@"X"]) {
            if (winningPosition >= 0) {
                [self.baseView addWinnerLine:board position:winningPosition];
            }
            [self.baseView addBigX:board];
        }
    } else {
        [self.baseView addOAtBoard:board position:pos light:!winnerNotFound];
        if (winnerNotFound && [self.gameBoard winnerForBoard:board player:@"O"]) {
            if (winningPosition >= 0) {
                [self.baseView addWinnerLine:board position:winningPosition];
            }
            [self.baseView addBigO:board];
        }
    }
    
//    [self.baseView moveBorderFrom:previousBorder to:[self.gameBoard enabledBoard]];
    [self.baseView setActiveBoard:[self.gameBoard enabledBoard]];
    previousBorder = [self.gameBoard enabledBoard];
    if([[self.gameBoard winner] isEqualToString:@"X"]) {
        [self.baseView showWinner:@"X"];
    } else if([[self.gameBoard winner] isEqualToString:@"O"]) {
        [self.baseView showWinner:@"O"];
    }
    [self.gameBoard switchTurn];
    [self sendTurn:self];
}

- (void)reloadColors {
    [self.baseView reloadColors];
}

- (void)touchCancelled {
    [self.gameBoard touchOutside];
    [self removeLastImage];
}

- (void) removeLastImage {
    if ([self.gameBoard previousBoard] >=0 && [self.gameBoard previousPosition] >= 0) {
        [self.baseView removeXOAtBoard:[self.gameBoard previousBoard] position:[self.gameBoard previousPosition]];
    }
}

// TODO: filter on being my turn
- (void)touchBeganInBoard:(int)board atPosition:(int)pos {
    if ([self.gameBoard validBoard:board position:pos]) {
        if ([self.gameBoard valueNotSetForBoard:board position:pos]) {
            if ([self.gameBoard touchAtBoard:board position:pos]) {
                [self removeLastImage];
                if ([[self.gameBoard turn] isEqualToString:@"X"]) {
                    [self.baseView addXAtBoard:board position:pos light:TRUE];
                } else {
                    [self.baseView addOAtBoard:board position:pos light:TRUE];
                }
            }
        }
    } else {
        [self.gameBoard touchOutside];
        [self removeLastImage];
    }
}

- (void)touchMovedInBoard:(int)board atPosition:(int)pos {
    if ([self.gameBoard currentBoard] == board && [self.gameBoard currentPos] == pos) {
        return;
    }
    if ([self.gameBoard validBoard:board position:pos]) {
        if ([self.gameBoard valueNotSetForBoard:board position:pos]) {
            if ([self.gameBoard touchAtBoard:board position:pos]) {
                [self removeLastImage];
                if ([[self.gameBoard turn] isEqualToString:@"X"]) {
                    [self.baseView addXAtBoard:board position:pos light:TRUE];
                } else {
                    [self.baseView addOAtBoard:board position:pos light:TRUE];
                }
            }
        }
    } else {
        [self.gameBoard touchOutside];
        [self removeLastImage];
    }
}

- (void)touchEndedInBoard:(int)board atPosition:(int)pos {
    if ([self.gameBoard validBoard:board position:pos]) {
        if ([self.gameBoard valueNotSetForBoard:board position:pos]) {
            if ([self.gameBoard touchAtBoard:board position:pos]) {
                [self removeLastImage];
                if ([[self.gameBoard turn] isEqualToString:@"X"]) {
                    [self.baseView addXAtBoard:board position:pos light:TRUE];
                } else {
                    [self.baseView addOAtBoard:board position:pos light:TRUE];
                }
            }
        }
    } else {
        [self.gameBoard touchOutside];
        [self removeLastImage];
    }
}

- (void)matchViewToGame {
    size = [self.gameBoard getSize];
    [self.baseView reset];
    for (int i = 0; i < self.gameBoard.boardData.count; i++) {
        NSArray* board = [self.gameBoard.boardData objectAtIndex:i];
        for (int j = 0; j < board.count; j++) {
            NSString* str = [board objectAtIndex:j];
            if ([str isEqualToString:@"X"]) {
                [self.baseView addXAtBoard:i position:j light:FALSE];
            } else if ([str isEqualToString:@"O"]) {
                [self.baseView addOAtBoard:i position:j light:FALSE];
            }
        }
    }
    
    for (int i = 0; i < self.gameBoard.winners.count; i++) {
        if (![[self.gameBoard.winners objectAtIndex:i] isEqualToString:@" "]) {
            int winPos = [[self.gameBoard.winningPositions objectAtIndex:i] intValue];
            if (winPos >= 0) {
                [self.baseView addWinnerLine:i position:winPos];
            }
            if ([[self.gameBoard.winners objectAtIndex:i] isEqualToString:@"X"]) {
                [self.baseView addBigX:i];
            } else if ([[self.gameBoard.winners objectAtIndex:i] isEqualToString:@"O"]) {
                [self.baseView addBigO:i];
            }
        }
    }
//    [self.baseView moveBorderFrom:previousBorder to:[self.gameBoard enabledBoard]];
    [self.baseView setActiveBoard:[self.gameBoard enabledBoard]];
    
}

#pragma Delegate Implementation

- (void)enterNewGame:(GKTurnBasedMatch *)match {
    NSLog(@"Entering new game...");
    [self newGame];
}

- (void)sendTurn:(id)sender {
    GKTurnBasedMatch* currentMatch = [[GCTurnBasedMatchHelper sharedInstance] currentMatch];
    NSUInteger currentIndex = [currentMatch.participants indexOfObject:currentMatch.currentParticipant];
    NSUInteger nextIndex = (currentIndex + 1) % [currentMatch.participants count];
    GKTurnBasedParticipant*  nextParticipant = [currentMatch.participants objectAtIndex:nextIndex];
    
    // check if other participant quit here???
    // nextParticipant.matchOutcome == GKTurnBasedMatchOutcomeQuit
    
    [currentMatch endTurnWithNextParticipant:nextParticipant matchData:[self.gameBoard exportData]
                           completionHandler:^(NSError* error) {
                               if (error) {
                                   NSLog(@"%@", error);
                               } else {
                                   
                               }
                           }];
    [self setTurn:FALSE];
}

- (void)takeTurn:(GKTurnBasedMatch *)match {
    // TODO: complete this (load match data and enable send button, etc.)
    [self layoutMatch:match];
    [self setTurn:TRUE];
}

- (void)layoutMatch:(GKTurnBasedMatch *)match {
    [self setGameBoard:[[GameBoard alloc] initWithData:[match matchData]]];
    [self matchViewToGame];
    [self setTurn:FALSE];
}

- (void)setTurn:(BOOL)myTurn {
    isMyTurn = myTurn;
    [bSelect setEnabled:isMyTurn];
    [bSelect setNeedsDisplay];
}

// Do I need this?
- (void)sendNotice:(NSString *)notice forMatch:(GKTurnBasedMatch *)match {
    UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"Another game needs your attention!" message:notice delegate:self cancelButtonTitle:@"Sweet" otherButtonTitles:nil];
    [av show];
}

- (void)recieveEndGame:(GKTurnBasedMatch*)match {
//    [self layoutMatch:match];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
