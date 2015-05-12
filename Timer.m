//
//  Timer.m
//  The-Pomodoro-iOS8
//
//  Created by Justin Huntington on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "Timer.h"

BOOL isOn;

@implementation Timer

+ (instancetype)sharedInstance
{
    static Timer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Timer alloc] init];
        sharedInstance.minutes = 1 ;
        sharedInstance.seconds = 05;
        
    });
                 
    return sharedInstance;
}

-(void) startTimer{
    isOn = YES;
    [self checkActive];
}

-(void) endTimer{
    isOn = NO;
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:RoundCompleteNotification object:nil];
}

- (void)decreaseSecond{
    if (_seconds > 0) {
        _seconds--;
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:SecondTickNotification object:nil];
    }else if (_minutes >0) {
        _minutes--;
        _seconds = 59;
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:SecondTickNotification object:nil];
    }else{
        [self endTimer];
    }
}

- (void)checkActive{
    
    if (isOn) {
        [self decreaseSecond];
        [self performSelector:@selector(checkActive) withObject:nil afterDelay:0.999];
        
    }
}

- (void)cancelTimer{
    isOn = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}



@end
