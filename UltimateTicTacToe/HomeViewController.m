//
//  HomeViewController.m
//  UltimateTicTacToe
//
//  Created by Franklin Totten on 12/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "GameCenterManager.h"
#import "ViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize label;
@synthesize gameCenterManager;
@synthesize matchStarted;
@synthesize myMatch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        count = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.label setText:[self readFile]];
    
    if([GameCenterManager isGameCenterAvailable]) {
        self.gameCenterManager = [[GameCenterManager alloc] init];
        [self.gameCenterManager setDelegate:self];
        [self.gameCenterManager authenticateLocalUser];
    } else {
        [self showAlertWithTitle: @"Game Center Support Required!"
						 message: @"The current device does not support Game Center, which this sample requires."];
    }
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void) showAlertWithTitle: (NSString*) title message: (NSString*) message
{
	UIAlertView* alert= [[UIAlertView alloc] initWithTitle: title message: message 
                                                  delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL];
	[alert show];
}

//- (void) showGameCenter
//{
//    if([GameCenterManager isGameCenterAvailable])
//    {
//        self.gameCenterManager= [[GameCenterManager alloc] init];
//        [self.gameCenterManager setDelegate:self];
//        [self.gameCenterManager authenticateLocalUser];
//        
//        [self updateCurrentScore];
//    }
//    else
//    {
//        [self showAlertWithTitle: @"Game Center Support Required!"
//                         message: @"The current device does not support Game Center, which this sample requires."];
//    }
//}

- (IBAction)writeToFile:(id)sender {
    NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                              NSUserDomainMask, YES);
    NSString *docDirectory = [arrayPaths objectAtIndex:0];
    NSString *string = [NSString stringWithFormat: @"Hello, World %d", count++];
    NSString *filePath = [docDirectory stringByAppendingString:@"/UltimateTicTacToeRecord.txt"];
    [string writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (IBAction)readFromFile:(id)sender {
    [self.label setText:[self readFile]];
}

- (NSString*)readFile {
    NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                              NSUserDomainMask, YES);
    NSString *docDirectory = [arrayPaths objectAtIndex:0];
    NSString *filePath = [docDirectory stringByAppendingString:@"/UltimateTicTacToeRecord.txt"];
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath
                                                       encoding:NSUTF8StringEncoding error:nil];
    return fileContents;
}

- (IBAction)findMatch:(id)sender
{
    GKMatchRequest *request = [[GKMatchRequest alloc] init];
    request.minPlayers = 2;
    request.maxPlayers = 2;
    
    GKTurnBasedMatchmakerViewController *mmvc = [[GKTurnBasedMatchmakerViewController alloc] initWithMatchRequest:request];
    mmvc.turnBasedMatchmakerDelegate = self;
    
    [self presentViewController:mmvc animated:YES completion:nil];
}

- (void)match:(GKMatch *)match didReceiveData:(NSData *)data fromPlayer:(NSString *)playerID {
    int i = 0;
    i = i+1;
}

- (void)turnBasedMatchmakerViewController:(GKTurnBasedMatchmakerViewController *)viewController didFindMatch:(GKTurnBasedMatch *)match
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self goToNext];
}

- (void )prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([segue.identifier isEqualToString:@"GameCenterStart"])
//    {
//        ViewController* gameVC = (ViewController*) segue.destinationViewController;
//        gameVC.delegate = self;
//        gameVC.match = (GKTurnBasedMatch*) sender;
//    }

}

- (void)turnBasedMatchmakerViewController:(GKTurnBasedMatchmakerViewController *)viewController playerQuitForMatch:(GKTurnBasedMatch *)match {
    [match endMatchInTurnWithMatchData:[[NSData alloc] init] completionHandler:nil];
}

- (void)turnBasedMatchmakerViewControllerWasCancelled:(GKTurnBasedMatchmakerViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)turnBasedMatchmakerViewController:(GKTurnBasedMatchmakerViewController *)viewController didFailWithError:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)goToNext {
    [self performSegueWithIdentifier:@"Test" sender:self];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	[self.gameCenterManager authenticateLocalUser];
}

- (void)processGameCenterAuth:(NSError*)error {
    if(error == NULL)
	{
//		[self.gameCenterManager reloadHighScoresForCategory: self.currentLeaderBoard];
	}
	else
	{
		UIAlertView* alert= [[UIAlertView alloc] initWithTitle: @"Game Center Account Required" 
                                                       message: [NSString stringWithFormat: @"Reason: %@", [error localizedDescription]]
                                                      delegate: self cancelButtonTitle: @"Try Again..." otherButtonTitles: NULL];
		[alert show];
	}
}

- (void)scoreReported:(NSError*)error {
    
}

- (void)reloadScoresComplete:(GKLeaderboard*)leaderBoard error: (NSError*)error {
    
}

- (void)achievementSubmitted:(GKAchievement*)ach error:(NSError*)error {
    
}

- (void)achievementResetResult:(NSError*)error {
    
}

- (void) mappedPlayerIDToPlayer: (GKPlayer*) player error: (NSError*) error;
{
	if((error == NULL) && (player != NULL))
	{
//		self.leaderboardHighScoreDescription= [NSString stringWithFormat: @"%@ got:", player.alias];
		
//		if(self.cachedHighestScore != NULL)
		{
//			self.leaderboardHighScoreString= self.cachedHighestScore;
		}
//		else
		{
//			self.leaderboardHighScoreString= @"-";
		}
        
	}
	else
	{
//		self.leaderboardHighScoreDescription= @"GameCenter Scores Unavailable";
//		self.leaderboardHighScoreDescription=  @"-";
	}
//	[self.tableView reloadData];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
