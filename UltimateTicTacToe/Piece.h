//
//  Piece.h
//  UltimateTicTacToe
//
//  Created by Franklin Totten on 7/23/14.
//
//

#import <UIKit/UIKit.h>

@interface Piece : UIView

@property (nonatomic, assign) CGFloat hue;
@property (nonatomic, assign) CGFloat saturation;
@property (nonatomic, assign) CGFloat brightness;
@property (nonatomic, assign) CGFloat pWidth;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) NSString* type;

-(id) initWithFrame:(CGRect)frame thickness:(CGFloat)pWidth borderWidth:(CGFloat)lineWidth;

- (void)reloadColorValues;
//- (void)setType:(NSString *)type;

@end
