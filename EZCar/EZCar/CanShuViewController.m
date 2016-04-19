//
//  CanShuViewController.m
//  EZCar
//
//  Created by 欧阳 on 16/4/19.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import "CanShuViewController.h"

@interface CanShuViewController ()

@end

@implementation CanShuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _objectForCS[@"kuanshi"];
    _tableView.allowsSelection = NO;//让tableview不被按

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//tableView  多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
//tableView 的显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //按钮取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



@end
