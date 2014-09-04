//
//  AppDelegate.h
//  UltimateTicTacToe
//
//  Created by Franklin Totten on 11/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BackgroundInitDelegate
-(void) loadBackgroundImage;
@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) id <BackgroundInitDelegate> backgroundDelegate;

@end
