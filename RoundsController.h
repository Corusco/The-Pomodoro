//
//  RoundsController.h
//  The-Pomodoro-iOS8
//
//  Created by Justin Huntington on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoundsController : NSObject

@property (assign, nonatomic) NSInteger currentRound;

+ (instancetype)sharedInstance;

- (void)roundSelected;

+ (NSArray *)imageNames;
+ (NSArray *)roundTimes;

@end
