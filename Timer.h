//
//  Timer.h
//  The-Pomodoro-iOS8
//
//  Created by Justin Huntington on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const SecondTickNotification = @"SecondTickNotification";
static NSString * const RoundCompleteNotification = @"RoundCompleteNotification";
static NSString * const NewRoundNotification = @"NewRoundNotification";

@interface Timer : NSObject

@property (nonatomic, assign) NSInteger minutes;
@property (nonatomic, assign) NSInteger seconds;

+ (instancetype)sharedInstance;
- (void) startTimer;
- (void) cancelTimer;
- (void)prepareForBackGround;
- (void)loadFromBackground;

@end
