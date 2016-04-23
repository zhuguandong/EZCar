//
//  LeftViewController.m
//  EZCar
//
//  Created by fang on 16/4/17.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import "LeftViewController.h"
#import "TabViewController.h"
#import "SignInViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)signOutAction:(UIButton *)sender forEvent:(UIEvent *)event {
    //退出登录
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        //判断推出是否成功
        if (!error) {
            //返回登录界面
            UINavigationController *tabVC = [Utilities getStoryboardInstance:@"Main" byIdentity:@"sigin"];
            [self presentViewController:tabVC animated:YES completion:nil];
        } else {
            [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
        }
    }];
}

- (IBAction)headAction:(UIButton *)sender forEvent:(UIEvent *)event {
    PFUser *user = [PFUser currentUser];
    if (user) {
        //        _headbutton.titleLabel.text = user.username;
        [_headbutton setTitle:user.username forState:UIControlStateNormal];
    } else {
        UINavigationController *tabVC = [Utilities getStoryboardInstance:@"Main" byIdentity:@"sigin"];
        [self presentViewController:tabVC animated:YES completion:nil];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    PFUser *user = [PFUser currentUser];
    if (user) {
        //        _headbutton.titleLabel.text = user.username;
        [_headbutton setTitle:user.username forState:UIControlStateNormal];
    }
}

@end
