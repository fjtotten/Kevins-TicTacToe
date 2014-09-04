//
//  Common.h
//  UltimateTicTacToe
//
//  Created by Franklin Totten on 6/11/14.
//
//

#import <Foundation/Foundation.h>

@interface Common : NSObject
    
void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor, CGPoint startPoint, CGPoint endPoint);
//void drawLinearGradientHorizontal(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor);
CGRect rectFor1PxStroke(CGRect rect);
void draw1PxStroke(CGContextRef context, CGPoint startPoint, CGPoint endPoint, CGColorRef color);
void drawXPxStroke(CGContextRef context, CGPoint startPoint, CGPoint endPoint, CGColorRef color, CGFloat width);
void drawGlossAndGradientVertical(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor, CGFloat glossAmountStart, CGFloat glossAmountEnd);
void drawGlossAndGradientHorizontal(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor, CGFloat glossAmountStart, CGFloat glossAmountEnd);
CGMutablePathRef createArcPathFromBottomOfRect(CGRect rect, CGFloat arcHeight);
CGMutablePathRef createRoundedRectForRect(CGRect rect, CGFloat radius);
CGMutablePathRef createXInRect(CGRect rect, CGFloat pWidth);
double radians(double degrees);

NSString* getBackgroundProperty();
NSString* getXHueProperty();
NSString* getXBrightnessProperty();
NSString* getXSaturationProperty();
NSString* getOHueProperty();
NSString* getOBrightnessProperty();
NSString* getOSaturationProperty();
NSString* getBarHueProperty();
NSString* getBarBrightnessProperty();
NSString* getBarSaturationProperty();
NSString* getBackgroundFilePath();


@end
