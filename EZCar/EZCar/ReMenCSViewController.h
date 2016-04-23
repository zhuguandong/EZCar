//
//  ReMenCSViewController.h
//  EZCar
//
//  Created by 贺先生 on 16/4/23.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReMenCSViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(strong,nonatomic) PFObject *objectForRM;
- (IBAction)BackAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UILabel *name;


@end
