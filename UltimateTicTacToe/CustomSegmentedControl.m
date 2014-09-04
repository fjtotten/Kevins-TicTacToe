//
//  CustomSegmentedControl.m
//  UltimateTicTacToe
//
//  Created by Franklin Totten on 7/27/14.
//
//

#import "CustomSegmentedControl.h"
#import "Common.h"

@implementation CustomSegmentedControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _hue = 0.5;
        _saturation = 0.5;
        _brightness = 0.5;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat actualBrightness = self.brightness;
    
    if (![self isEnabled]) {
        actualBrightness -= 0.20;
    } else if (self.state == UIControlStateHighlighted) {
        actualBrightness -= 0.10;
    }
    
    
//    UIColor* outerTop = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:1.0*actualBrightness alpha:0.1];
//    UIColor* outerBottom = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:0.8*actualBrightness alpha:0.1];
//    UIColor* innerStroke = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:0.8*actualBrightness alpha:0.5];
//    UIColor* innerTop = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:0.9*actualBrightness alpha:0.1];
//    UIColor* innerBottom = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:0.7*actualBrightness alpha:0.1];
    
//    UIColor* blackColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    UIColor* fadedColor = [UIColor colorWithWhite:1.0 alpha:0.3];
//    UIColor* highlightStart = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.4];
//    UIColor* highlightStop = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
//    UIColor* shadowColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.5];
    
    CGFloat outerMargin = 5.0f;
    CGRect outerRect = CGRectInset(self.bounds, outerMargin, outerMargin);
    CGMutablePathRef outerPath = createRoundedRectForRect(self.bounds, 6.0);
    
    CGFloat innerMargin = 3.0f;
    CGRect innerRect = CGRectInset(outerRect, innerMargin, innerMargin);
    CGMutablePathRef innerPath = createRoundedRectForRect(innerRect, 6.0);
    
    CGFloat highlightMargin = 2.0f;
    CGRect highlightRect = CGRectInset(outerRect, highlightMargin, highlightMargin);
    CGMutablePathRef highlightPath = createRoundedRectForRect(highlightRect, 6.0);
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, fadedColor.CGColor);
    CGContextAddPath(context, outerPath);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
//    if (self.state != UIControlStateHighlighted && [self isEnabled]) {
//        CGContextSaveGState(context);
//        CGContextSetFillColorWithColor(context, outerTop.CGColor);
//        CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3.0, shadowColor.CGColor);
//        CGContextAddPath(context, outerPath);
//        CGContextFillPath(context);
//        CGContextRestoreGState(context);
//    }
    
    //    if (_custom) {
    //    CGContextSaveGState(context);
    //    CGContextAddPath(context, outerPath);
    //    CGContextClip(context);
    //    drawGlossAndGradientVertical(context, outerRect, outerTop.CGColor, outerBottom.CGColor, 0.35);
    //    CGContextRestoreGState(context);
    //    }
//    CGContextSaveGState(context);
//    CGContextAddPath(context, innerPath);
//    CGContextClip(context);
//    drawGlossAndGradientVertical(context, innerRect, innerTop.CGColor, innerBottom.CGColor, 0.35);
//    CGContextRestoreGState(context);
//    
//    
//    if (self.state != UIControlStateHighlighted && [self isEnabled]) {
//        CGContextSaveGState(context);
//        CGContextSetLineWidth(context, 4.0);
//        CGContextAddPath(context, outerPath);
//        CGContextAddPath(context, highlightPath);
//        CGContextEOClip(context);
//        CGPoint startPoint = CGPointMake(CGRectGetMidX(outerRect), CGRectGetMinY(outerRect));
//        CGPoint endPoint = CGPointMake(CGRectGetMidX(outerRect), CGRectGetMaxY(outerRect));
//        drawLinearGradient(context, outerRect, highlightStart.CGColor, highlightStop.CGColor, startPoint, endPoint);
//        CGContextRestoreGState(context);
//    }
//    
//    CGContextSaveGState(context);
//    CGContextSetLineWidth(context, 2.0);
//    CGContextSetStrokeColorWithColor(context, blackColor.CGColor);
//    CGContextAddPath(context, outerPath);
//    CGContextStrokePath(context);
//    CGContextRestoreGState(context);
//    
//    CGContextSaveGState(context);
//    CGContextSetLineWidth(context, 2.0);
//    CGContextSetStrokeColorWithColor(context, innerStroke.CGColor);
//    CGContextAddPath(context, innerPath);
//    CGContextClip(context);
//    CGContextAddPath(context, innerPath);
//    CGContextStrokePath(context);
//    CGContextRestoreGState(context);
    
    CFRelease(outerPath);
    CFRelease(innerPath);
    CFRelease(highlightPath);
}
//*/

@end
