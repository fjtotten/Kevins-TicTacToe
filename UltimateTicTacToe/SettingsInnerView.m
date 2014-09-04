//
//  SettingsView.m
//  UltimateTicTacToe
//
//  Created by Franklin Totten on 7/27/14.
//
//

#import "SettingsInnerView.h"
#import "Piece.h"
#import "Common.h"

@implementation SettingsInnerView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)setupX {
    [_xPiece setType:@"X"];
    [_xHueSlider setValue:[[NSUserDefaults standardUserDefaults] floatForKey:getXHueProperty()]];
    [_xBrightnessSlider setValue:[[NSUserDefaults standardUserDefaults] floatForKey:getXBrightnessProperty()]];
    [_xSaturationSlider setValue:[[NSUserDefaults standardUserDefaults] floatForKey:getXSaturationProperty()]];
    [_xPiece reloadColorValues];
}


- (void)setupO {
    [_oPiece setType:@"O"];
    [_oHueSlider setValue:[[NSUserDefaults standardUserDefaults] floatForKey:getOHueProperty()]];
    [_oBrightnessSlider setValue:[[NSUserDefaults standardUserDefaults] floatForKey:getOBrightnessProperty()]];
    [_oSaturationSlider setValue:[[NSUserDefaults standardUserDefaults] floatForKey:getOSaturationProperty()]];
    [_oPiece reloadColorValues];
}

- (void)setupBar {
    [_barHueSlider setValue:[[NSUserDefaults standardUserDefaults] floatForKey:getBarHueProperty()]];
    [_barBrightnessSlider setValue:[[NSUserDefaults standardUserDefaults]
                                    floatForKey:getBarBrightnessProperty()]];
    [_barSaturationSlider setValue:[[NSUserDefaults standardUserDefaults]
                                    floatForKey:getBarSaturationProperty()]];
    [_board reloadBarColors];
}

- (IBAction)xHueChanged {
    [_xPiece setHue:[_xHueSlider value]];
    [_xPiece setNeedsDisplay];
}

- (IBAction)xSaturationChanged {
    [_xPiece setSaturation:[_xSaturationSlider value]];
    [_xPiece setNeedsDisplay];
}

- (IBAction)xBrightnessChanged {
    [_xPiece setBrightness:[_xBrightnessSlider value]];
    [_xPiece setNeedsDisplay];
}

- (IBAction)oHueChanged {
    [_oPiece setHue:[_oHueSlider value]];
    [_oPiece setNeedsDisplay];
}

- (IBAction)oSaturationChanged {
    [_oPiece setSaturation:[_oSaturationSlider value]];
    [_oPiece setNeedsDisplay];
}

- (IBAction)oBrightnessChanged {
    [_oPiece setBrightness:[_oBrightnessSlider value]];
    [_oPiece setNeedsDisplay];
}

- (IBAction)barHueChanged {
    [_board cSetHue:[_barHueSlider value]];
}

- (IBAction)barSaturationChanged {
    [_board cSetSaturation:[_barSaturationSlider value]];
}

- (IBAction)barBrightnessChanged {
    [_board cSetBrightness:[_barBrightnessSlider value]];
}

- (void)changeView:(int)viewNum {
    switch (viewNum) {
        case 0:
            [_xView setAlpha:1.0];
            [_oView setAlpha:0.0];
            [_barView setAlpha:0.0];
            [_backdropView setAlpha:0.0];
            break;
        case 1:
            [_xView setAlpha:0.0];
            [_oView setAlpha:1.0];
            [_barView setAlpha:0.0];
            [_backdropView setAlpha:0.0];
            break;
        case 2:
            [_xView setAlpha:0.0];
            [_oView setAlpha:0.0];
            [_barView setAlpha:1.0];
            [_backdropView setAlpha:0.0];
            break;
        case 3:
            [_xView setAlpha:0.0];
            [_oView setAlpha:0.0];
            [_barView setAlpha:0.0];
            [_backdropView setAlpha:1.0];
            break;
        default:
            [_xView setAlpha:0.0];
            [_oView setAlpha:0.0];
            [_barView setAlpha:0.0];
            [_backdropView setAlpha:0.0];
            break;
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
