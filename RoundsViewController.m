//
//  RoundsViewController.m
//  The-Pomodoro-iOS8
//
//  Created by Justin Huntington on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "RoundsViewController.h"

@interface RoundsViewController ()

@end

@implementation RoundsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (instancetype)sharedInstance
{
    static RoundsViewController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RoundsViewController alloc] init];
    });
                 
    return sharedInstance;
}

-(NSArray *)roundTimes{
    return @[@25, @5, @25, @5, @25, @5, @25, @15];
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
