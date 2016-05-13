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

@property (weak, nonatomic) IBOutlet UILabel *cunzaiLbl;
- (IBAction)chooseAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)goVSAction:(UIButton *)sender forEvent:(UIEvent *)event;

@property (weak, nonatomic) IBOutlet UIButton *chooce;
- (IBAction)removeAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end
