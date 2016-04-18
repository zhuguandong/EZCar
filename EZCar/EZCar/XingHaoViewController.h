//
//  XingHaoViewController.h
//  EZCar
//
//  Created by 欧阳 on 16/4/18.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XingHaoViewController : UIViewController
@property(strong,nonatomic) PFObject *objectForXH;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
