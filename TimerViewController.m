//
//  TimerViewController.m
//  The-Pomodoro-iOS8
//
//  Created by Justin Huntington on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "TimerViewController.h"
#import "Timer.h"

@interface TimerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *timerButton;

@end

@implementation TimerViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self registerForNotifications];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)buttonSelected:(id)sender {
    self.timerButton.enabled = NO;
    [[Timer sharedInstance] startTimer];
    
}

- (void)updateTimerLabel {
    NSInteger minutes = [Timer sharedInstance].minutes;
    NSInteger seconds = [Timer sharedInstance].seconds;
    
    self.timerLabel.text = [self timerStringWithMinutes:minutes andSeconds:seconds];
    self.view.backgroundColor = [UIColor whiteColor];
    self.timerLabel.textColor = [UIColor blackColor];
    
    if (minutes == 5) {
        [self.timerButton setTitle:@"Go get a drink" forState:UIControlStateNormal];
    }else if (minutes == 25){
        [self.timerButton setTitle:@"Get back to work you slob" forState:UIControlStateNormal];
//    } else {
//        [self.timerButton setTitle:@"Kick it off!" forState:UIControlStateNormal];
    }
    
}

- (NSString *)timerStringWithMinutes:(NSInteger)minutes andSeconds:(NSInteger)seconds {
    NSString *timerString;
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    if (minutes >= 10)
    {
        timerString = [NSString stringWithFormat:@"%li:", (long)minutes];
    } else {
        timerString = [NSString stringWithFormat:@"0%li:", (long)minutes];
    }
    
    if (seconds >= 10)
    {
        timerString = [timerString stringByAppendingString: [NSString stringWithFormat:@"%li", (long)seconds]];
    } else {
        timerString = [timerString stringByAppendingString: [NSString stringWithFormat:@"0%li", (long)seconds]];
    }
    
    if (minutes < 1) {
        //NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:@"lessThanAMinute" object:nil];
    }
    
    if (minutes == 0 && seconds == 0) {
        [nc postNotificationName:@"timeEnd" object:nil];
    }
    
    return timerString;
    
}

- (void)registerForNotifications {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(updateTimerLabel) name:SecondTickNotification object:nil];
    [nc addObserver:self selector:@selector(newRound) name:NewRoundNotification object:nil];
    [nc addObserver:self selector:@selector(newRound) name:RoundCompleteNotification object:nil];
    [nc addObserver:self selector:@selector(setTimerLabelRed) name:@"lessThanAMinute" object:nil];
    [nc addObserver:self selector:@selector(timeEndAppearance) name:@"timeEnd" object:nil];
}

- (void)dealloc {
    [self unregisterForNotifications];
}


- (void)unregisterForNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)newRound {
    [self updateTimerLabel];
    self.timerButton.enabled = YES;
}

- (void)setTimerLabelRed {
    self.timerLabel.textColor = [UIColor redColor];
}

- (void)timeEndAppearance {
    self.timerLabel.textColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor redColor];
    self.timerButton.backgroundColor = [UIColor redColor];
    [self.timerButton setTitle:@"Bring the next round" forState:UIControlStateNormal];
    [self.timerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
