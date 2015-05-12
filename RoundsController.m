//
//  RoundsController.m
//  The-Pomodoro-iOS8
//
//  Created by Justin Huntington on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "RoundsController.h"
#import "Timer.h"

@implementation RoundsController

+ (instancetype)sharedInstance
{
    static RoundsController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RoundsController alloc] init];
    });
                 
    return sharedInstance;
}


+ (NSArray *)roundTimes{
    return @[@25, @5, @25, @5, @25, @5, @25, @15];
}

+ (NSArray *)imageNames {
    NSArray *imageArray = @[@"working", @"playing", @"working", @"playing", @"working", @"playing", @"working", @"sleeping"];
    return imageArray;
}

- (void)roundSelected{
    [Timer sharedInstance].minutes = [[RoundsController roundTimes][self.currentRound] integerValue];
    [Timer sharedInstance].seconds = 0;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NewRoundNotification object:nil];
}

@end
