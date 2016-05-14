//
//  SouSuoViewController.m
//  EZCar
//
//  Created by admin1 on 16/4/26.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import "SouSuoViewController.h"

@interface SouSuoViewController ()<UISearchBarDelegate>

@end

@implementation SouSuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)back:(UIButton *)sender forEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
