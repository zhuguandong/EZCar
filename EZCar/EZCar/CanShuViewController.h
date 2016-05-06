//
//  CanShuViewController.h
//  EZCar
//
//  Created by 欧阳 on 16/4/19.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CanShuViewController : UIViewController
@property(strong,nonatomic) PFObject *objectForCS;

- (IBAction)addAction:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
