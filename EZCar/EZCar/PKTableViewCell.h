//
//  PKTableViewCell.h
//  EZCar
//
//  Created by 欧阳 on 16/4/24.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *car1CS;
@property (weak, nonatomic) IBOutlet UILabel *car2CS;
@property (weak, nonatomic) IBOutlet UILabel *car3CS;
@property (weak, nonatomic) IBOutlet UILabel *car4CS;
@property (weak, nonatomic) IBOutlet UILabel *car5CS;

@end
