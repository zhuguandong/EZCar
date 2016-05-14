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
    [self signOut];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)signOut {
    PFUser *currentUser = [PFUser currentUser];
    NSLog(@"currentUser = %@", currentUser);
    if (!currentUser) {
        _singOut.enabled = NO;
        _singOut.hidden = YES;
    }
    
}

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

- (IBAction)ReMenAction:(UIButton *)sender forEvent:(UIEvent *)event {
    //根据故事版的名称和故事版中页面的名称获得这个页面
    TabViewController *tabVC = [Utilities getStoryboardInstance:@"Main" byIdentity:@"RM"];
    [self presentViewController:tabVC animated:YES completion:nil];

}

- (IBAction)headAction:(UIButton *)sender forEvent:(UIEvent *)event {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.25 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        POPBasicAnimation *headDownAnimation = [POPBasicAnimation animation];
        headDownAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewScaleXY];
        headDownAnimation.duration = 0.25f;
        //终态根据控件本身属性作为参照来设置
        headDownAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
        //让_zoomButton执行上述动画并给上述动画起键名
        [_headbutton pop_addAnimation:headDownAnimation forKey:@"headDownAnimation"];
    });
    
    PFUser *user = [PFUser currentUser];
    if (user) {
        //        _headbutton.titleLabel.text = user.username;
        [_headbutton setTitle:user.username forState:UIControlStateNormal];
    } else {
        UINavigationController *tabVC = [Utilities getStoryboardInstance:@"Main" byIdentity:@"sigin"];
        [self presentViewController:tabVC animated:YES completion:nil];
    }
}

- (IBAction)headDownAction:(UIButton *)sender forEvent:(UIEvent *)event {
    //初始化一个POP动画制作器
    POPBasicAnimation *headUpAnimation = [POPBasicAnimation animation];
    //设置动画类型（通过propertyWithName方法根据动画名字或者枚举来设置)(这里设置为缩放动画)
    headUpAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewScaleXY];
    //设置动画的时间
    headUpAnimation.duration = 0.25f;
    //设置动画的终态（不同的动画类型下，终态的设置方法截然不同）
    headUpAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.2, 1.2)];
    //让_zoomButton执行上述动画并给上述动画起键名
    [_headbutton pop_addAnimation:headUpAnimation forKey:@"headUpAnimation"];
}

- (IBAction)headOutAction:(UIButton *)sender forEvent:(UIEvent *)event {
    POPBasicAnimation *headDownAnimation = [POPBasicAnimation animation];
    headDownAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewScaleXY];
    headDownAnimation.duration = 0.25f;
    //终态根据控件本身属性作为参照来设置
    headDownAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    //让_zoomButton执行上述动画并给上述动画起键名
    [_headbutton pop_addAnimation:headDownAnimation forKey:@"headDownAnimation"];
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
