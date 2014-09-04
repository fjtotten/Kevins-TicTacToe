//
//  SettingsView.h
//  UltimateTicTacToe
//
//  Created by Franklin Totten on 7/27/14.
//
//

#import <UIKit/UIKit.h>
#import "Piece.h"
#import "CustomBoard.h"

@interface SettingsInnerView : UIView

@property (nonatomic, retain) IBOutlet UIView* xView;
@property (nonatomic, retain) IBOutlet Piece* xPiece;
@property (nonatomic, retain) IBOutlet UISlider* xHueSlider;
@property (nonatomic, retain) IBOutlet UISlider* xSaturationSlider;
@property (nonatomic, retain) IBOutlet UISlider* xBrightnessSlider;

@property (nonatomic, retain) IBOutlet UIView* oView;
@property (nonatomic, retain) IBOutlet Piece* oPiece;
@property (nonatomic, retain) IBOutlet UISlider* oHueSlider;
@property (nonatomic, retain) IBOutlet UISlider* oSaturationSlider;
@property (nonatomic, retain) IBOutlet UISlider* oBrightnessSlider;

@property (nonatomic, retain) IBOutlet UIView* barView;
@property (nonatomic, retain) IBOutlet CustomBoard* board;
@property (nonatomic, retain) IBOutlet UISlider* barHueSlider;
@property (nonatomic, retain) IBOutlet UISlider* barSaturationSlider;
@property (nonatomic, retain) IBOutlet UISlider* barBrightnessSlider;

@property (nonatomic, retain) IBOutlet UIView* backdropView;

- (void)changeView:(int)viewNum;
- (void)setupX;
- (void)setupO;
- (void)setupBar;

- (IBAction)xHueChanged;
- (IBAction)xSaturationChanged;
- (IBAction)xBrightnessChanged;

- (IBAction)oHueChanged;
- (IBAction)oSaturationChanged;
- (IBAction)oBrightnessChanged;

- (IBAction)barHueChanged;
- (IBAction)barSaturationChanged;
- (IBAction)barBrightnessChanged;

@end
