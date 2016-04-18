//
//  XingHaoViewController.m
//  EZCar
//
//  Created by 欧阳 on 16/4/18.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import "XingHaoViewController.h"

@interface XingHaoViewController ()
@property(strong,nonatomic) NSMutableArray *xingHaoForShow;


@end

@implementation XingHaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _xingHaoForShow = [NSMutableArray new];
    [self requestData];
    

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //NSString *objectID = _objectForXH.objectId;
    
}

//拿数据
- (void)requestData {
    [_xingHaoForShow removeAllObjects];
    NSString *objectId = _objectForXH.objectId;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"info = %@ ",objectId];
    
    PFQuery *query = [PFQuery queryWithClassName:@"CanShu" predicate:predicate];
    
    
    
    
    
    //让导航条失去交互能力
    self.navigationController.view.userInteractionEnabled = NO;
    //在根视图上创建一朵菊花，并转动
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    //查询语句
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [avi stopAnimating];
        if (!error) {
            NSLog(@"objects = %@",objects);
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

