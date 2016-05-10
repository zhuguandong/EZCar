//
//  PKViewController.h
//  EZCar
//
//  Created by 欧阳 on 16/4/24.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(strong,nonatomic) PFObject *object;

@property (weak, nonatomic) IBOutlet UILabel *car1Name;


@end
