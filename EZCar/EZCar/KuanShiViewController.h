//
//  KuanShiViewController.h
//  EZCar
//
//  Created by 欧阳 on 16/4/19.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KuanShiViewController : UIViewController
@property(strong,nonatomic) PFObject *objectForKS;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIImageView *photoImage;

@end
