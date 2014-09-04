//
//  Piece.m
//  UltimateTicTacToe
//
//  Created by Franklin Totten on 7/23/14.
//
//

#import "Piece.h"
#import "Common.h"

@implementation Piece

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame thickness:0.2 borderWidth:0.5];
}

- (id)initWithFrame:(CGRect)frame thickness:(CGFloat)pWidth borderWidth:(CGFloat)lineWidth
{
    self = [super initWithFrame:frame];
    if (self) {
        _hue = 0.5;
        _saturation = 0.5;
        _brightness = 0.5;
        _pWidth = pWidth;
        _lineWidth = lineWidth;
        _type = @" ";
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _hue = 0.5;
        _saturation = 0.5;
        _brightness = 0.5;
        _pWidth = 0.2;
        _lineWidth = 1.0;
        _type = @" ";
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if ([_type isEqualToString:@"X"]) {
        [self drawX:rect];
    } else if ([_type isEqualToString:@"O"]) {
        [self drawO:rect];
    }
}

//- (void)setType:(NSString *)type {
//    self.type = type;
//    [self reloadHueValues];
//}

- (void)reloadColorValues {
    if ([_type isEqualToString:@"X"]) {
        [self updateXValues];
    } else if ([_type isEqualToString:@"O"]) {
        [self updateOValues];
    }
}

- (void)updateXValues {
    [self setHue:[[NSUserDefaults standardUserDefaults] floatForKey:getXHueProperty()]];
    [self setBrightness:[[NSUserDefaults standardUserDefaults] floatForKey:getXBrightnessProperty()]];
    [self setSaturation:[[NSUserDefaults standardUserDefaults] floatForKey:getXSaturationProperty()]];
    [self setNeedsDisplay];
}

- (void)updateOValues {
    [self setHue:[[NSUserDefaults standardUserDefaults] floatForKey:getOHueProperty()]];
    [self setBrightness:[[NSUserDefaults standardUserDefaults] floatForKey:getOBrightnessProperty()]];
    [self setSaturation:[[NSUserDefaults standardUserDefaults] floatForKey:getOSaturationProperty()]];
    [self setNeedsDisplay];
}

- (void)drawX:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
//    CGFloat actualBrightness = 1.0;
    
    
    UIColor* outerTop = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:1.0*self.brightness alpha:1.0];
    UIColor* outerBottom = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:0.8*self.brightness alpha:1.0];
    
    UIColor* blackColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];

    
    CGPoint middle = CGPointMake((self.bounds.size.width-_lineWidth) / 2.0, (self.bounds.size.height-_lineWidth) / 2.0);
    CGPoint rBottom = CGPointMake(self.bounds.size.width - _lineWidth, self.bounds.size.height - _lineWidth);
    CGFloat width = self.frame.size.width * _pWidth;
    CGFloat halfWidth = width / 2.0;
    CGFloat height = self.frame.size.height * _pWidth;
    CGFloat halfHeight = height / 2.0;
    
    CGPoint lMid = CGPointMake(middle.x - halfWidth, middle.y);
    CGPoint lBottom = CGPointMake(0, rBottom.y);
    CGPoint lmBottom = CGPointMake(width, rBottom.y);
    CGPoint bMid = CGPointMake(middle.x, middle.y + halfHeight);
    CGPoint rmBottom = CGPointMake(rBottom.x - width, rBottom.y);
    CGPoint rMid = CGPointMake(middle.x + halfWidth, middle.y);
    CGPoint rTop = CGPointMake(rBottom.x, 0);
    CGPoint rmTop = CGPointMake(rBottom.x - width, 0);
    CGPoint tMid = CGPointMake(middle.x, middle.y - halfHeight);
    CGPoint lmTop = CGPointMake(width, 0);
    
    CGContextSaveGState(context);
    CGMutablePathRef xPath = createXInRect(self.bounds, _pWidth);
    CGContextAddPath(context, xPath);
    CGContextClip(context);
    drawGlossAndGradientVertical(context, self.bounds, outerTop.CGColor, outerBottom.CGColor, 0.25, 0);
    CGContextRestoreGState(context);
    
    drawXPxStroke(context, CGPointMake(0, 0), lMid, blackColor.CGColor, _lineWidth);
    drawXPxStroke(context, lMid, lBottom, blackColor.CGColor, _lineWidth);
    drawXPxStroke(context, lBottom, lmBottom, blackColor.CGColor, _lineWidth);
    drawXPxStroke(context, lmBottom, bMid, blackColor.CGColor, _lineWidth);
    drawXPxStroke(context, bMid, rmBottom, blackColor.CGColor, _lineWidth);
    drawXPxStroke(context, rmBottom, rBottom, blackColor.CGColor, _lineWidth);
    drawXPxStroke(context, rBottom, rMid, blackColor.CGColor, _lineWidth);
    drawXPxStroke(context, rMid, rTop, blackColor.CGColor, _lineWidth);
    drawXPxStroke(context, rTop, rmTop, blackColor.CGColor, _lineWidth);
    drawXPxStroke(context, rmTop, tMid, blackColor.CGColor, _lineWidth);
    drawXPxStroke(context, tMid, lmTop, blackColor.CGColor, _lineWidth);
    drawXPxStroke(context, lmTop, CGPointMake(0, 0), blackColor.CGColor, _lineWidth);
    
    CFRelease(xPath);
}

- (void)drawO:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor* outerTop = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:1.0*self.brightness alpha:1.0];
    UIColor* outerBottom = [UIColor colorWithHue:self.hue saturation:self.saturation brightness:0.8*self.brightness alpha:1.0];
    
    UIColor* blackColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];

    CGFloat width = self.bounds.size.width * _pWidth;
    CGFloat height = self.bounds.size.height * _pWidth / 2.0;
    
    CGRect outerRect = CGRectMake(_lineWidth / 2.0, _lineWidth / 2.0, self.bounds.size.width - _lineWidth,
                                  self.bounds.size.height - _lineWidth);
    CGRect innerRect = CGRectMake(width, height, self.bounds.size.width - 2 * width,
                                  self.bounds.size.height - 2 * height);
    
    CGContextSaveGState(context);
    CGMutablePathRef outerOval = CGPathCreateMutable();
    CGPathAddEllipseInRect(outerOval, NULL, outerRect);
    CGMutablePathRef innerOval = CGPathCreateMutable();
    CGPathAddEllipseInRect(innerOval, NULL, innerRect);
    
    CGContextAddPath(context, outerOval);
    CGContextAddPath(context, innerOval);
    CGContextEOClip(context);
    drawGlossAndGradientVertical(context, self.bounds, outerTop.CGColor, outerBottom.CGColor, 0.25, 0);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextAddPath(context, outerOval);
    CGContextSetStrokeColorWithColor(context, blackColor.CGColor);
    CGContextSetLineWidth(context, _lineWidth);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextAddPath(context, innerOval);
    CGContextSetStrokeColorWithColor(context, blackColor.CGColor);
    CGContextSetLineWidth(context, _lineWidth);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    
    
    CGPathRelease(outerOval);
    CGPathRelease(innerOval);
}

@end
