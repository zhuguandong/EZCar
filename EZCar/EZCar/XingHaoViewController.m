//
//  XingHaoViewController.m
//  EZCar
//
//  Created by 欧阳 on 16/4/18.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import "XingHaoViewController.h"

@interface XingHaoViewController ()

@end

@implementation XingHaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestData {
    PFQuery *query = [PFQuery queryWithClassName:@"Xinghao"];
    [query includeKey:@"info"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"objects = %@",objects);
            for (PFObject *object in objects) {
                PFRelation *relation = [object relationForKey:@"info"];
                PFQuery *subQuery = [relation query];
                [subQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable subObjects, NSError * _Nullable error) {
                    if (!error) {
                        NSLog(@"subObjects = %@",subObjects);
                    }
                    
                }];
            }
        } else {
            NSLog(@"%@",error.description);
        }
    }];
    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
