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

- (void)requestData {
    PFQuery *query = [PFQuery queryWithClassName:@"Xinghao"];
    [query whereKey:@"info" equalTo:_objectForXH];
    [query includeKey:@"info"];
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        self.navigationController.view.userInteractionEnabled = YES;
        [avi stopAnimating];
        if (!error) {
            NSLog(@"objects = %@",objects);
            _xingHaoForShow = [NSMutableArray arrayWithArray:objects];
            [_tableView reloadData];
        
        }else {
            NSLog(@"Error: %@",error.userInfo);
            [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
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

