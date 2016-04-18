//
//  SecondViewController.m
//  EZCar
//
//  Created by 欧阳 on 16/4/18.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import "SecondViewController.h"
#import "SecondTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "XingHaoViewController.h"

@interface SecondViewController ()
@property(strong,nonatomic) NSMutableArray *carNameForShow;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _carNameForShow = [NSMutableArray new];
    [self requestData];
    _tableView.tableFooterView = [[UITableView alloc]init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//拿数据
- (void)requestData {
    [_carNameForShow removeAllObjects];
    
    PFQuery *query = [PFQuery queryWithClassName:@"PinPai"];
    
    [query addAscendingOrder:@"Carname"];
   
    //让导航条失去交互能力
    self.navigationController.view.userInteractionEnabled = NO;
    //在根视图上创建一朵菊花，并转动
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    //查询语句
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        //让导航条恢复交互能力
        self.navigationController.view.userInteractionEnabled = YES;
        //停止菊花动画
        [avi stopAnimating];
        if (!error) {
            _carNameForShow = [NSMutableArray arrayWithArray:objects];
            NSLog(@"objects = %@",_carNameForShow);
            [_tableView reloadData];
        }else{
            NSLog(@"Error: %@",error.userInfo);
            [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
        }
    }];
}











//tableView  多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _carNameForShow.count;
}
//tableView 的显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *obj = _carNameForShow[indexPath.row];
    NSString *carname = obj[@"carname"];
    cell.carName.text = carname;
    PFFile *photoFile = obj[@"tubiao"];
    //获取数据库中某个文件的网络路径1
    NSString *photoURLStr = photoFile.url;
    NSURL *photoURL = [NSURL URLWithString:photoURLStr];
    //结合SDWebImage通过图片路径来实现异步加载和缓存（本案中加载到一个图片视图上）
    [cell.logoImage sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"Image-5"]];
    
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //按钮取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = _tableView.indexPathForSelectedRow;
    //根据上诉行数，获取该行所对应的数据
    PFObject *obj = _carNameForShow[indexPath.row];
    
    XingHaoViewController *cdVC = segue.destinationViewController;
    cdVC.objectForXH = obj;
    
    
   }


@end
