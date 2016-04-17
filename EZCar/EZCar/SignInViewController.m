//
//  SignInViewController.m
//  EZCar
//
//  Created by zhu on 16/4/16.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import "SignInViewController.h"
#import "TabViewController.h"
#import <ECSlidingViewController/ECSlidingViewController.h>
#import "LeftViewController.h"

@interface SignInViewController ()

@property(strong, nonatomic) ECSlidingViewController *slidingVC;

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化一个BOOL型的单例化全局变量来表示是否成功执行了注册操作，默认为否
    [[StorageMgr singletonStorageMgr] addKey:@"SignUpSuccessfully" andValue:@NO];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//每次来到页面都会执行，时机是将要出现
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //判断用户是否记忆了用户名
    if (![[Utilities getUserDefaults:@"Username"] isKindOfClass:[NSNull class]]) {
        //如果有记忆就显示在用户名输入框中
        _usernameTF.text = [Utilities getUserDefaults:@"Username"];
    }
}

//每一次这个页面出现的时候都会调用，并且时机点是页面已然出现后
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //判断是否是注册成功后回到的这个登录页面
    if ([[[StorageMgr singletonStorageMgr] objectForKey:@"SignUpSuccessfully"] boolValue] == YES) {
        
        //在自动登录前将flag设置为no
        [[StorageMgr singletonStorageMgr] removeObjectForKey:@"SignUpSuccessfully"];
        [[StorageMgr singletonStorageMgr] addKey:@"SignUpSuccessfully" andValue:@NO];
        
        //从单列化全局变量中提取用户名和密码
        NSString *username = [[StorageMgr singletonStorageMgr] objectForKey:@"Username"];
        NSString *password = [[StorageMgr singletonStorageMgr] objectForKey:@"Password"];
        
        //清除用完的用户名密码
        [[StorageMgr singletonStorageMgr] removeObjectForKey:@"Username"];
        [[StorageMgr singletonStorageMgr] removeObjectForKey:@"Password"];
        
        //执行自动登录
        //调用下面封装登录操作
        [self sigInWithUsername:username andPassword:password];
        
    }
}

//封装登录操作
-(void)sigInWithUsername:(NSString *)username andPassword:(NSString *)password {
    
    //菊花转啊转（Utility里封装好了的）
    UIActivityIndicatorView *avi =[Utilities getCoverOnView:self.view];
    
    //开始登录
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * _Nullable user, NSError * _Nullable error) {
        //登录完成的回调
        [avi stopAnimating];//菊花停转
        //判断登录是否成功
        if (user) {
            NSLog(@"登录成功");
            //记忆用户名
            [Utilities setUserDefaults:@"Username" content:username];
            
            //将密码文本输入框中的内容清空
            _passwordTF.text = @"";
            
            //跳转到首页
            [self popUpHome];
        }else {
            switch (error.code) {
                case 101:
                    [Utilities popUpAlertViewWithMsg:@"用户名或密码错误" andTitle:nil onView:self];
                    break;
                case 100:
                    [Utilities popUpAlertViewWithMsg:@"网络不给力，请稍候再试" andTitle:nil onView:self];
                default:
                    [Utilities popUpAlertViewWithMsg:@"服务器正在维护，请稍候再试" andTitle:nil onView:self];
                    break;
            }
        }
    }];
}


-(void)popUpHome {
    
    //根据故事版的名称和故事版中页面的名称获得这个页面
    TabViewController *tabVC = [Utilities getStoryboardInstance:@"Main" byIdentity:@"Tab"];
    
    //初始化移门的门框,并设置中间那扇门
    _slidingVC = [ECSlidingViewController slidingWithTopViewController:tabVC];
    //设置开门关门的耗时
    _slidingVC.defaultTransitionDuration = 0.25f;
    //设置控制门开关的手势(这里同时对触摸和拖拽响应)
    _slidingVC.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGesturePanning|ECSlidingViewControllerAnchoredGestureTapping;
    
    //设置上述手势的识别范围
    [tabVC.view addGestureRecognizer:_slidingVC.panGesture];
    
    //根据故事版id获得左滑页面的实例
     LeftViewController *leftVC = [Utilities getStoryboardInstance:@"Main" byIdentity:@"Left"];
    //设置移门靠左的那扇门
    _slidingVC.underLeftViewController = leftVC;
    //设置移门的开闭程度(设置左侧页面显示时，可以显示屏幕宽度3/4宽度)
    _slidingVC.anchorRightPeekAmount = UI_SCREEN_W / 3;
    
    //modal方式跳转到上述页面
    [self presentViewController:_slidingVC animated:YES completion:nil];
    
}



- (IBAction)siginInAction:(UIButton *)sender forEvent:(UIEvent *)event {
    NSString *username = _usernameTF.text;
    NSString *password = _passwordTF.text;
    
    if (username.length == 0 || password.length == 0 ) {
        [Utilities popUpAlertViewWithMsg:@"请输入账号密码" andTitle:nil onView:self];
        return;
    }
    //调用上面封装登录操作
    [self sigInWithUsername:username andPassword:password];
}


//当键盘右下角按钮被按后执行的方法
-(BOOL)texrFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}
//触摸屏幕时调用的方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //按屏幕任何地方缩回键盘
    [self.view endEditing:YES];
}

@end
