//
//  BoardView.h
//  UltimateTicTacToe
//
//  Created by Franklin Totten on 11/14/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Piece.h"
#import "CustomBoard.h"

@interface BoardView : UIView {
    int size;
    int position;
    double barRadiusW;
    double barRadiusH;
    CustomBoard* board;
    NSArray* xos;
//    UIImageView* bigView;
    Piece* bigView;
    UIImageView* borderView;
}
@property(nonatomic, retain) CustomBoard* board;
@property(nonatomic, retain) NSArray* xos;
@property(nonatomic, retain) UIImageView* borderView;
//@property(nonatomic, retain) UIImageView* bigView;
@property(nonatomic, retain) Piece* bigView;

- (id)initWithFramePlus:(CGRect)frame size:(int)s position:(int)pos width:(int)width;
- (void)addXAt:(int)pos light:(BOOL)light;
- (void)addOAt:(int)pos light:(BOOL)light;
- (void)addBigX;
- (void)addBigO;
- (void)removeXOAt:(int)pos;
- (int)inBox:(CGPoint)touch;
- (BOOL)pointInside:(CGPoint)touch;
- (void)removeBorder;
- (void)addBorder;
- (void)addWinnerLine:(int)position;
- (void)setActive:(BOOL)active;
- (void)reset;
- (void)reloadPieceColors;
- (void)reloadBarColors;
// Make a Custom Board class as an extra step between boardview and bar

@end
