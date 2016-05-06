//
//  ShouCangViewController.m
//  EZCar
//
//  Created by 欧阳 on 16/5/6.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import "ShouCangViewController.h"

@interface ShouCangViewController ()
@property(strong,nonatomic) NSMutableArray *ShouCangForShow;

@end

@implementation ShouCangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    _ShouCangForShow = [NSMutableArray new];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestData {
    [_ShouCangForShow removeAllObjects];
    PFUser *currentUser = [PFUser currentUser];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"user = %@", currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Vs" predicate:predicate];
    [query includeKey:@"canshu"];
    self.navigationController.view.userInteractionEnabled = NO;
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        self.navigationController.view.userInteractionEnabled = YES;
        [avi stopAnimating];
        if (!error) {
            NSLog(@"objects = %@",objects);
            
            _ShouCangForShow = [NSMutableArray arrayWithArray:objects];
            [_tableView reloadData];
            
        }else {
            NSLog(@"Error: %@",error.userInfo);
            [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
        }
        
    }];
    
}








- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _ShouCangForShow.count;
}
//tableView 的显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier=@"Cell";//创建一个静态字符串Cell表示需要复用的细胞名称
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    PFObject *obj = _ShouCangForShow[indexPath.row];
    cell.textLabel.text = obj[@"canshu"][@"xinghao"];
    
    return cell;
}

- (IBAction)backAction:(UIBarButtonItem *)sender {
    [ self dismissViewControllerAnimated: YES completion: nil ];
}




@end
