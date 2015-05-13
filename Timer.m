//
//  Timer.m
//  The-Pomodoro-iOS8
//
//  Created by Justin Huntington on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "Timer.h"
#import <UIKit/UIKit.h>


BOOL isOn;

@interface Timer ()

@property (strong, nonatomic) NSDate *expirationDate;

@end



@implementation Timer




+ (instancetype)sharedInstance
{
    static Timer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Timer alloc] init];
        sharedInstance.minutes = 00;
        sharedInstance.seconds = 02;
        
    });
                 
    return sharedInstance;
}

-(void) startTimer{
    isOn = YES;
    
    NSTimeInterval timerLength = self.minutes * 60 + self.seconds;
    self.expirationDate = [NSDate dateWithTimeIntervalSinceNow:timerLength];
    
    UILocalNotification *notification = [UILocalNotification new];
    notification.timeZone = [NSTimeZone localTimeZone];
    notification.fireDate = self.expirationDate;
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.alertBody = @"Times Up!";
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
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
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void)prepareForBackGround {
    [[NSUserDefaults standardUserDefaults] setObject: self.expirationDate forKey:@"expirationDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)loadFromBackground {
    self.expirationDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"expirationDate"];
    NSTimeInterval seconds = [self.expirationDate timeIntervalSinceNow];
    self.minutes = seconds / 60;
    self.seconds = seconds - (self.minutes * 60);
}

@end
