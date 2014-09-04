//
//  CustomBoard.h
//  UltimateTicTacToe
//
//  Created by Franklin Totten on 8/10/14.
//
//

#import <UIKit/UIKit.h>

@interface CustomBoard : UIView {
    int size;
    double barRadiusW;
    double barRadiusH;
    NSArray* verticalBars;
    NSArray* horizontalBars;
    CGFloat hue;
    CGFloat saturation;
    CGFloat brightness;
}

@property(nonatomic, retain) NSArray* verticalBars;
@property(nonatomic, retain) NSArray* horizontalBars;
@property (nonatomic, assign) CGFloat hue;
@property (nonatomic, assign) CGFloat saturation;
@property (nonatomic, assign) CGFloat brightness;

- (id)initWithFramePlus:(CGRect)frame size:(int)s verticalWidth:(int)width horizHeight:(int)height;
- (void)reloadBarColors;
- (void)cSetHue:(CGFloat)val;
- (void)cSetBrightness:(CGFloat)val;
- (void)cSetSaturation:(CGFloat)val;

@end
