//
//  FirstViewController.h
//  EZCar
//
//  Created by 欧阳 on 16/4/17.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)menuAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)ToSouSuo:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *chooseAction;

- (IBAction)chooseAction:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIView *Upview;

@end
