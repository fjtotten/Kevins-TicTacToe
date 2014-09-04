//
//  SettingsViewController.h
//  UltimateTicTacToe
//
//  Created by Franklin Totten on 7/27/14.
//
//

#import <UIKit/UIKit.h>
#import "CustomSegmentedControl.h"
#import "SettingsInnerView.h"

@protocol SettingsNavigationHandler <NSObject>
- (void)moveSettingsToHome;
- (void)presentImagePicker:(UIImagePickerController*)picker animated:(BOOL)animated;
- (void)setBackgroundImage;
@end

@interface SettingsView : UIView <UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    UIImageView* backgroundImageView;
    UIImage* backgroundImage;
    id <SettingsNavigationHandler> navHandler;
}

@property (nonatomic, retain) IBOutlet CustomSegmentedControl* selectControl;
@property (nonatomic, retain) IBOutlet SettingsInnerView* settingsView;
@property (nonatomic, retain) IBOutlet UIImageView* backgroundImageView;
@property (nonatomic, retain) UIImage* backgroundImage;
@property (nonatomic, retain) id <SettingsNavigationHandler> navHandler;

- (IBAction)back;
- (IBAction)selectResponse:(id)sender;
- (IBAction)apply;
- (IBAction)selectBackground;
- (void)loadView;

@end
