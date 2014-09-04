//
//  CustomBoard.m
//  UltimateTicTacToe
//
//  Created by Franklin Totten on 7/14/14.
//
//

#import "CustomBar.h"
#import "Common.h"

@implementation CustomBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        _hue = 0.5;
        _saturation = 0.5;
        _brightness = 0.5;
    }
    return self;
}

//- (void)reloadColorValues {
//    [self setHue:[[NSUserDefaults standardUserDefaults] floatForKey:getBarHueProperty()]];
//    [self setBrightness:[[NSUserDefaults standardUserDefaults] floatForKey:getBarBrightnessProperty()]];
//    [self setSaturation:[[NSUserDefaults standardUserDefaults] floatForKey:getBarSaturationProperty()]];
//}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor* outerTop = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:1.0*self.brightness alpha:1.0];
    UIColor* outerBottom = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:0.8*self.brightness alpha:1.0];
//    UIColor* innerStroke = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:0.8*actualBrightness alpha:1.0];
//    UIColor* innerTop = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:0.9*actualBrightness alpha:1.0];
//    UIColor* innerBottom = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:0.7*actualBrightness alpha:1.0];
//    
//    UIColor* blackColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
//
    CGFloat width;
    if (rect.size.width < rect.size.height) {
        width = rect.size.width / 4.0;
    } else {
        width = rect.size.height / 4.0;
    }
    
    CGFloat outerMargin = 3.0f;
    CGRect outerRect = CGRectInset(self.bounds, outerMargin, outerMargin);
    CGMutablePathRef outerPath = createRoundedRectForRect(outerRect, width);
    
//    CGFloat innerMargin = 2.0f;
//    CGRect innerRect = CGRectInset(outerRect, innerMargin, innerMargin);
//    CGMutablePathRef innerPath = createRoundedRectForRect(innerRect, width);
//    
//    CGFloat highlightMargin = 1.0f;
//    CGRect highlightRect = CGRectInset(outerRect, highlightMargin, highlightMargin);
//    CGMutablePathRef highlightPath = createRoundedRectForRect(highlightRect, width);
    
    CGContextSaveGState(context);
    CGContextAddPath(context, outerPath);
    CGContextClip(context);
    if (rect.size.width > rect.size.height) {
        drawGlossAndGradientVertical(context, outerRect, outerTop.CGColor, outerBottom.CGColor, 0.35, 0.05);
    } else {
        drawGlossAndGradientHorizontal(context, outerRect, outerTop.CGColor, outerBottom.CGColor, 0.35, 0.05);
    }
    CGContextRestoreGState(context);
    
//    CGContextSaveGState(context);
//    CGContextAddPath(context, innerPath);
//    CGContextClip(context);
//    drawGlossAndGradientVertical(context, innerRect, innerTop.CGColor, innerBottom.CGColor);
//    CGContextRestoreGState(context);
    
//    CGContextSaveGState(context);
//    CGContextSetLineWidth(context, 2.0);
//    CGContextSetStrokeColorWithColor(context, blackColor.CGColor);
//    CGContextAddPath(context, outerPath);
//    CGContextStrokePath(context);
//    CGContextRestoreGState(context);
    
//    CGContextSaveGState(context);
//    CGContextSetLineWidth(context, 2.0);
//    CGContextSetStrokeColorWithColor(context, innerStroke.CGColor);
//    CGContextAddPath(context, innerPath);
//    CGContextClip(context);
//    CGContextAddPath(context, innerPath);
//    CGContextStrokePath(context);
//    CGContextRestoreGState(context);
    
    CFRelease(outerPath);
//    CFRelease(innerPath);
//    CFRelease(highlightPath);

}


@end
