//
//  ShopCSViewController.h
//  EZCar
//
//  Created by fang on 16/4/25.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCSViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic) PFObject *objectForCS;
@end
