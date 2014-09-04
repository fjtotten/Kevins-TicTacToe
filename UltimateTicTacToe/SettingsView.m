//
//  SettingsViewController.m
//  UltimateTicTacToe
//
//  Created by Franklin Totten on 7/27/14.
//
//

#import "SettingsView.h"
#import "Common.h"

@interface SettingsView ()

@end

@implementation SettingsView
@synthesize backgroundImageView;
@synthesize backgroundImage;
@synthesize navHandler;

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)loadView {
    [_settingsView setupX];
    [_settingsView setupO];
    [_settingsView setupBar];
    [_settingsView changeView:(int)_selectControl.selectedSegmentIndex];
}

- (IBAction)selectResponse:(id)sender {
    [_settingsView changeView:(int)_selectControl.selectedSegmentIndex];
}

- (IBAction)back {
    [self.backgroundImageView setAlpha:0];
    [navHandler moveSettingsToHome];
}

- (IBAction)apply {
    switch ([_selectControl selectedSegmentIndex]) {
        case 0: {
            // X Case
            [[NSUserDefaults standardUserDefaults] setFloat:[_settingsView.xHueSlider value]
                                                     forKey:getXHueProperty()];
            [[NSUserDefaults standardUserDefaults] setFloat:[_settingsView.xBrightnessSlider value]
                                                     forKey:getXBrightnessProperty()];
            [[NSUserDefaults standardUserDefaults] setFloat:[_settingsView.xSaturationSlider value]
                                                     forKey:getXSaturationProperty()];
            break;
        }
        case 1: {
            // O Case
            [[NSUserDefaults standardUserDefaults] setFloat:[_settingsView.oHueSlider value]
                                                     forKey:getOHueProperty()];
            [[NSUserDefaults standardUserDefaults] setFloat:[_settingsView.oBrightnessSlider value]
                                                     forKey:getOBrightnessProperty()];
            [[NSUserDefaults standardUserDefaults] setFloat:[_settingsView.oSaturationSlider value]
                                                     forKey:getOSaturationProperty()];
            break;
        }
        case 2: {
            // Board Case
            [[NSUserDefaults standardUserDefaults] setFloat:[_settingsView.barHueSlider value]
                                                     forKey:getBarHueProperty()];
            [[NSUserDefaults standardUserDefaults] setFloat:[_settingsView.barBrightnessSlider value]
                                                     forKey:getBarBrightnessProperty()];
            [[NSUserDefaults standardUserDefaults] setFloat:[_settingsView.barSaturationSlider value]
                                                     forKey:getBarSaturationProperty()];
            break;
        }
        case 3: {
            NSData* imageData = UIImageJPEGRepresentation(self.backgroundImage, 1);
            [imageData writeToFile:getBackgroundFilePath() atomically:YES];
            [navHandler setBackgroundImage];
            break;
        }
        default:
            break;
    }
}

- (IBAction)selectBackground {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
	
//	if((UIButton *) sender == choosePhotoBtn) {
//		picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//	} else {
//		picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//	}
	
	[self.navHandler presentImagePicker:picker animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissModalViewControllerAnimated:YES];
    [self setBackgroundImage:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
	[self.backgroundImageView setImage:self.backgroundImage];
    [self.backgroundImageView setAlpha:1];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
