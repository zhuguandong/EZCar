//
//  SignUpViewController.h
//  EZCar
//
//  Created by zhu on 16/4/16.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *EmailTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwdTF;
- (IBAction)signUpAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end
