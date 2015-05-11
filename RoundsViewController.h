//
//  RoundsViewController.h
//  The-Pomodoro-iOS8
//
//  Created by Justin Huntington on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoundsViewController : UIViewController

@property (readonly, strong, nonatomic) NSArray *roundTimes;
@property (assign, nonatomic) NSInteger currentRound;

+ (instancetype)sharedInstance;

@end
