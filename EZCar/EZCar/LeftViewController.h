//
//  LeftViewController.h
//  EZCar
//
//  Created by fang on 16/4/17.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *singOut;

- (IBAction)signOutAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UIButton *headbutton;
- (IBAction)headAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)headDownAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)headOutAction:(UIButton *)sender forEvent:(UIEvent *)event;


- (IBAction)ReMenAction:(UIButton *)sender forEvent:(UIEvent *)event;


@end
