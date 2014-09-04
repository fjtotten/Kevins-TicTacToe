//
//  CustomButton.m
//  UltimateTicTacToe
//
//  Created by Franklin Totten on 6/11/14.
//
//

#import "CustomButton.h"
#import "Common.h"

@implementation CustomButton


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        _hue = 0.5;
        _saturation = 0.5;
        _brightness = 0.5;
        _custom = FALSE;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat actualBrightness = self.brightness;
    
    if (![self isEnabled]) {
        actualBrightness -= 0.20;
    } else if (self.state == UIControlStateHighlighted) {
        actualBrightness -= 0.10;
    }
    
    
    UIColor* outerTop = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:1.0*actualBrightness alpha:0.1];
    UIColor* outerBottom = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:0.8*actualBrightness alpha:0.1];
    UIColor* innerStroke = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:0.8*actualBrightness alpha:0.5];
    UIColor* innerTop = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:0.9*actualBrightness alpha:0.1];
    UIColor* innerBottom = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:0.7*actualBrightness alpha:0.1];
    
    UIColor* blackColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    UIColor* highlightStart = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.4];
    UIColor* highlightStop = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    UIColor* shadowColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.5];
    
    CGFloat outerMargin = 5.0f;
    CGRect outerRect = CGRectInset(self.bounds, outerMargin, outerMargin);
    CGMutablePathRef outerPath = createRoundedRectForRect(outerRect, 6.0);
    
    CGFloat innerMargin = 3.0f;
    CGRect innerRect = CGRectInset(outerRect, innerMargin, innerMargin);
    CGMutablePathRef innerPath = createRoundedRectForRect(innerRect, 6.0);
    
    CGFloat highlightMargin = 2.0f;
    CGRect highlightRect = CGRectInset(outerRect, highlightMargin, highlightMargin);
    CGMutablePathRef highlightPath = createRoundedRectForRect(highlightRect, 6.0);
    
    if (self.state != UIControlStateHighlighted && [self isEnabled]) {
        CGContextSaveGState(context);
        CGContextSetFillColorWithColor(context, outerTop.CGColor);
        CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3.0, shadowColor.CGColor);
        CGContextAddPath(context, outerPath);
        CGContextFillPath(context);
        CGContextRestoreGState(context);
    }
    
//    if (_custom) {
//    CGContextSaveGState(context);
//    CGContextAddPath(context, outerPath);
//    CGContextClip(context);
//    drawGlossAndGradientVertical(context, outerRect, outerTop.CGColor, outerBottom.CGColor, 0.35);
//    CGContextRestoreGState(context);
//    }
    CGContextSaveGState(context);
    CGContextAddPath(context, innerPath);
    CGContextClip(context);
    drawGlossAndGradientVertical(context, innerRect, innerTop.CGColor, innerBottom.CGColor, 0.35, 0.05);
    CGContextRestoreGState(context);
    
    
    if (self.state != UIControlStateHighlighted && [self isEnabled]) {
        CGContextSaveGState(context);
        CGContextSetLineWidth(context, 4.0);
        CGContextAddPath(context, outerPath);
        CGContextAddPath(context, highlightPath);
        CGContextEOClip(context);
        CGPoint startPoint = CGPointMake(CGRectGetMidX(outerRect), CGRectGetMinY(outerRect));
        CGPoint endPoint = CGPointMake(CGRectGetMidX(outerRect), CGRectGetMaxY(outerRect));
        drawLinearGradient(context, outerRect, highlightStart.CGColor, highlightStop.CGColor, startPoint, endPoint);
        CGContextRestoreGState(context);
    }
    
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, blackColor.CGColor);
    CGContextAddPath(context, outerPath);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, innerStroke.CGColor);
    CGContextAddPath(context, innerPath);
    CGContextClip(context);
    CGContextAddPath(context, innerPath);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CFRelease(outerPath);
    CFRelease(innerPath);
    CFRelease(highlightPath);
    
}

- (void)hesitateUpdate {
    [self setNeedsDisplay];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self setNeedsDisplay];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    [self setNeedsDisplay];
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    [self setNeedsDisplay];
    [self performSelector:@selector(hesitateUpdate) withObject:nil afterDelay:0.1];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self setNeedsDisplay];
    [self performSelector:@selector(hesitateUpdate) withObject:nil afterDelay:0.1];
}

- (void)setHue:(CGFloat)hue {
    _hue = hue;
    [self setNeedsDisplay];
}

- (void)setSaturation:(CGFloat)saturation {
    _saturation = saturation;
    [self setNeedsDisplay];
}

- (void)setBrightness:(CGFloat)brightness {
    _brightness = brightness;
    [self setNeedsDisplay];
}


@end
