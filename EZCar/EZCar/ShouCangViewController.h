//
//  ShouCangViewController.h
//  EZCar
//
//  Created by 欧阳 on 16/5/6.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShouCangViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property BOOL completed;

- (IBAction)chooseAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)goVSAction:(UIButton *)sender forEvent:(UIEvent *)event;

@property (weak, nonatomic) IBOutlet UIButton *chooce;

@end
