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

@property (weak, nonatomic) IBOutlet UILabel *car2Name;
@property (weak, nonatomic) IBOutlet UILabel *car3Name;

@property (weak, nonatomic) IBOutlet UILabel *car4Name;
@property (weak, nonatomic) IBOutlet UILabel *car5Name;
- (IBAction)清空:(UIBarButtonItem *)sender;


@end
