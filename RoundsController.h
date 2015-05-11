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
@property (strong, nonatomic, readonly) NSArray *roundTimes;

+ (instancetype)sharedInstance;

- (void)roundSelected;

@end
