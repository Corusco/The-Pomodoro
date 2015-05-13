//
//  AppearanceController.m
//  The-Pomodoro-iOS8
//
//  Created by Justin Huntington on 5/12/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "AppearanceController.h"



@implementation AppearanceController


+ (void)initializeAppearanceDefaults {
    
//    [AppearanceController registerForNotifications];
    NSDictionary *titleTextDictionary = @{
                                          NSForegroundColorAttributeName : [UIColor whiteColor],
                                          NSFontAttributeName : [UIFont fontWithName:@"Avenir-Light" size:18]
                                          };
    
    [[UINavigationBar appearance] setBackgroundColor:[UIColor blueColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:titleTextDictionary];
    [[UITabBar appearance] setTintColor:[UIColor grayColor]];
    [[UIButton appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UIButton appearance] setTintColor:[UIColor blackColor]];
    
     
}

@end
