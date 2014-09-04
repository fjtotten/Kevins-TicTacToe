//
//  AppDelegate.m
//  UltimateTicTacToe
//
//  Created by Franklin Totten on 11/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "GCTurnBasedMatchHelper.h"
#import "Common.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize navController = _navController;

static NSString* defaultBackgroundFile = @"test.jpg";

static CGFloat defaultXHue = 0.6;
static CGFloat defaultXBrightness = 0.5;
static CGFloat defaultXSaturation = 0.5;

static CGFloat defaultOHue = 0.4;
static CGFloat defaultOBrightness = 0.5;
static CGFloat defaultOSaturation = 0.5;

static CGFloat defaultBarHue = 0.5;
static CGFloat defaultBarBrightness = 0.5;
static CGFloat defaultBarSaturation = 0.5;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    [[GCTurnBasedMatchHelper sharedInstance] authenticateLocalUser];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:getBackgroundProperty()] == NULL) {
        [[NSUserDefaults standardUserDefaults] setObject:defaultBackgroundFile forKey:getBackgroundProperty()];
    }
    if ([[NSUserDefaults standardUserDefaults] floatForKey:getXHueProperty()] == 0) {
        [[NSUserDefaults standardUserDefaults] setFloat:defaultXHue forKey:getXHueProperty()];
    }
    if ([[NSUserDefaults standardUserDefaults] floatForKey:getXBrightnessProperty()] == 0) {
        [[NSUserDefaults standardUserDefaults] setFloat:defaultXBrightness forKey:getXBrightnessProperty()];
    }
    if ([[NSUserDefaults standardUserDefaults] floatForKey:getXSaturationProperty()] == 0) {
        [[NSUserDefaults standardUserDefaults] setFloat:defaultXSaturation forKey:getXSaturationProperty()];
    }
    if ([[NSUserDefaults standardUserDefaults] floatForKey:getOHueProperty()] == 0) {
        [[NSUserDefaults standardUserDefaults] setFloat:defaultOHue forKey:getOHueProperty()];
    }
    if ([[NSUserDefaults standardUserDefaults] floatForKey:getOBrightnessProperty()] == 0) {
        [[NSUserDefaults standardUserDefaults] setFloat:defaultOBrightness forKey:getOBrightnessProperty()];
    }
    if ([[NSUserDefaults standardUserDefaults] floatForKey:getOSaturationProperty()] == 0) {
        [[NSUserDefaults standardUserDefaults] setFloat:defaultOSaturation forKey:getOSaturationProperty()];
    }
    if ([[NSUserDefaults standardUserDefaults] floatForKey:getBarHueProperty()] == 0) {
        [[NSUserDefaults standardUserDefaults] setFloat:defaultBarHue forKey:getBarHueProperty()];
    }
    if ([[NSUserDefaults standardUserDefaults] floatForKey:getBarBrightnessProperty()] == 0) {
        [[NSUserDefaults standardUserDefaults] setFloat:defaultBarBrightness forKey:getBarBrightnessProperty()];
    }
    if ([[NSUserDefaults standardUserDefaults] floatForKey:getBarSaturationProperty()] == 0) {
        [[NSUserDefaults standardUserDefaults] setFloat:defaultBarSaturation forKey:getBarSaturationProperty()];
    }
    if (![[NSFileManager defaultManager] fileExistsAtPath:getBackgroundFilePath()]) {
        UIImage* image = [UIImage imageNamed:defaultBackgroundFile];
        NSData* imageData = UIImageJPEGRepresentation(image, 1);
        [imageData writeToFile:getBackgroundFilePath() atomically:YES];
        [self.backgroundDelegate loadBackgroundImage];
    }
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
