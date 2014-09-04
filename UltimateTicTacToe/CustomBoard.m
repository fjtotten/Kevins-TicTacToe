//
//  CustomBoard.m
//  UltimateTicTacToe
//
//  Created by Franklin Totten on 8/10/14.
//
//

#import "CustomBoard.h"
#import "CustomBar.h"
#import "Common.h"

@implementation CustomBoard
@synthesize verticalBars;
@synthesize horizontalBars;
@synthesize hue;
@synthesize brightness;
@synthesize saturation;

- (id)initWithFramePlus:(CGRect)frame size:(int)s verticalWidth:(int)width horizHeight:(int)height {
    self = [super initWithFrame:frame];
    if (self) {
        size = s;
        barRadiusW = width;
        barRadiusH = height;
        
        [self createHorizontalBars];
        [self createVerticalBars];
        [self cSetHue:[[NSUserDefaults standardUserDefaults] floatForKey:getBarHueProperty()]];
        [self cSetBrightness:[[NSUserDefaults standardUserDefaults] floatForKey:getBarBrightnessProperty()]];
        [self cSetSaturation:[[NSUserDefaults standardUserDefaults] floatForKey:getBarSaturationProperty()]];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        size = 3;
        barRadiusW = self.bounds.size.width / 40.0;
        barRadiusH = self.bounds.size.width / 40.0;
        
        [self createHorizontalBars];
        [self createVerticalBars];
        [self cSetHue:[[NSUserDefaults standardUserDefaults] floatForKey:getBarHueProperty()]];
        [self cSetBrightness:[[NSUserDefaults standardUserDefaults] floatForKey:getBarBrightnessProperty()]];
        [self cSetSaturation:[[NSUserDefaults standardUserDefaults] floatForKey:getBarSaturationProperty()]];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)createVerticalBars {
    NSMutableArray* vBars = [[NSMutableArray alloc] init];
    for(int i = 1; i < size; i++) {
        CustomBar* bar = [[CustomBar alloc] initWithFrame:CGRectMake((self.frame.size.width*i)/size-barRadiusH, 0, 2*barRadiusH, self.frame.size.height)];
        [vBars addObject:bar];
        [self addSubview:bar];
    }
    [self setVerticalBars:vBars];
}

- (void)createHorizontalBars {
    NSMutableArray* hBars = [[NSMutableArray alloc] init];
    for(int i = 1; i < size; i++) {
        CustomBar* bar = [[CustomBar alloc] initWithFrame:CGRectMake(0, (self.frame.size.height*i)/size-barRadiusW, self.frame.size.width, 2*barRadiusW)];
        [hBars addObject:bar];
        [self addSubview:bar];
    }
    [self setHorizontalBars:hBars];
}

- (void)reloadBarColors {
    [self cSetHue:[[NSUserDefaults standardUserDefaults] floatForKey:getBarHueProperty()]];
    [self cSetBrightness:[[NSUserDefaults standardUserDefaults] floatForKey:getBarBrightnessProperty()]];
    [self cSetSaturation:[[NSUserDefaults standardUserDefaults] floatForKey:getBarSaturationProperty()]];
}

- (void)cSetHue:(CGFloat)val {
    self.hue = val;
    for (CustomBar* bar in self.verticalBars) {
        [bar setHue:val];
        [bar setNeedsDisplay];
    }
    for (CustomBar* bar in self.horizontalBars) {
        [bar setHue:val];
        [bar setNeedsDisplay];
    }
}

- (void)cSetBrightness:(CGFloat)val {
    self.brightness = val;
    for (CustomBar* bar in self.verticalBars) {
        [bar setBrightness:val];
        [bar setNeedsDisplay];
    }
    for (CustomBar* bar in self.horizontalBars) {
        [bar setBrightness:val];
        [bar setNeedsDisplay];
    }
}

- (void)cSetSaturation:(CGFloat)val {
    self.saturation = val;
    for (CustomBar* bar in self.verticalBars) {
        [bar setSaturation:saturation];
        [bar setNeedsDisplay];
    }
    for (CustomBar* bar in self.horizontalBars) {
        [bar setSaturation:saturation];
        [bar setNeedsDisplay];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
