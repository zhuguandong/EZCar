//
//  ReMenViewController.h
//  EZCar
//
//  Created by 贺先生 on 16/4/23.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReMenViewController : UIViewController
- (IBAction)Action:(UIButton *)sender forEvent:(UIEvent *)event;


@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end
