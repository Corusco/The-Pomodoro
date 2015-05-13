//
//  AppDelegate.m
//  The-Pomodoro-iOS8
//
//  Created by Taylor Mott on 18.2.2015.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "AppDelegate.h"
#import "TimerViewController.h"
#import "RoundsViewController.h"
#import "AppearanceController.h"
#import "Timer.h"

@interface AppDelegate ()

@property (nonatomic,strong) AppearanceController *appearanceController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    self.appearanceController = [AppearanceController new];

    [AppearanceController initializeAppearanceDefaults];
    
    TimerViewController *timerVC = [[TimerViewController alloc] init];
    timerVC.tabBarItem.title = @"Timer";
    timerVC.tabBarItem.image = [UIImage imageNamed:@"timer"];
    
    RoundsViewController *roundsVC = [[RoundsViewController alloc] init];
    roundsVC.tabBarItem.title = @"Rounds";
    roundsVC.tabBarItem.image = [UIImage imageNamed:@"rounds"];
    
    UINavigationController *roundsNavVC = [[UINavigationController alloc] initWithRootViewController:roundsVC];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[timerVC, roundsNavVC];
    
    self.window.rootViewController = tabBarController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[Timer sharedInstance] prepareForBackGround];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[Timer sharedInstance] loadFromBackground];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:
                                                                         (UIUserNotificationTypeAlert |
                                                                          UIUserNotificationTypeBadge |
                                                                          UIUserNotificationTypeSound) categories:nil]];
    }
}


-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Time's Up!" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDestructive handler:nil];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Start Next Round" style:UIAlertActionStyleDefault handler:^
                              (UIAlertAction *action) {
                                  [[Timer sharedInstance] startTimer];
                              }
                              ];
    
    [alertController addAction:action];
    [alertController addAction:action2];
    
    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
