//
//  ViewController.m
//  RaspiCar
//
//  Created by Mellong on 15/7/12.
//  Copyright (c) 2015年 Tendencystudio. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

typedef enum : NSUInteger {
    AMButtonTypeForward = 100,
    AMButtonTypeBackward,
    AMButtonTypeLeft,
    AMButtonTypeRight,
    AMButtonTypeStop
} AMButtonType;


@interface ViewController ()

@end

@implementation ViewController
{
    AFHTTPRequestOperationManager *_manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _manager = [AFHTTPRequestOperationManager manager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  Touch up inside, without Forward button.
 *
 *  @param sender button
 */
- (IBAction)onButtonClicked:(UIButton *)sender {
    NSString *direction = @"t_stop";
    [self sendCommand:direction];
}

- (IBAction)onButtonTouchDown:(UIButton *)sender {
    NSString *direction;

    switch (sender.tag) {
        case AMButtonTypeForward:
            direction = @"t_up";
            break;
        case AMButtonTypeBackward:
            direction = @"t_down";
            break;
        case AMButtonTypeRight:
            direction = @"t_left";
            break;
        case AMButtonTypeStop:
            direction = @"t_stop";
            break;
        case AMButtonTypeLeft:
            direction = @"t_right";
            break;
        default:
            break;
    }
    [self sendCommand:direction];
}

- (void)sendCommand:(NSString *)direction {
    [_manager POST:@"http://192.168.0.222:2000/ctl" parameters:@{@"id": direction} success:^void(AFHTTPRequestOperation * operation, id success) {
        
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"error: %@", error.description);
    }];
}

@end
