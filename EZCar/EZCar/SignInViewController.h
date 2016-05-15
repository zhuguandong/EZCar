//
//  SignInViewController.h
//  EZCar
//
//  Created by zhu on 16/4/16.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
- (IBAction)siginInAction:(UIButton *)sender forEvent:(UIEvent *)event;

- (IBAction)gogogo:(UIButton *)sender forEvent:(UIEvent *)event;


@end
