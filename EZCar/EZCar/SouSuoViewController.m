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
    //加上搜索栏
//    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 35)];//allocate titleView
//    UIColor *color =  self.navigationController.navigationBar.barTintColor;
//    [titleView setBackgroundColor:color];
//    UISearchBar *searchBar = [[UISearchBar alloc] init];
//    searchBar.delegate = self;
//    searchBar.frame = CGRectMake(0, 0, 220, 30);
//    searchBar.backgroundColor = color;
//    searchBar.layer.cornerRadius = 18;
//    searchBar.layer.masksToBounds = YES;
//    [searchBar.layer setBorderWidth:8];
//    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];//边框白色
//    searchBar.placeholder = @"宝马4S店";
//    [titleView addSubview:searchBar];
//    //Set to titleView
//    [self.navigationItem.titleView sizeToFit];
//    self.navigationItem.titleView = titleView;
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

- (IBAction)back:(UIButton *)sender forEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
