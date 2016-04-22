//
//  KuanShiViewController.m
//  EZCar
//
//  Created by 欧阳 on 16/4/19.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import "KuanShiViewController.h"
#import "KuanShiTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "CanShuViewController.h"

@interface KuanShiViewController ()
@property(strong,nonatomic) NSMutableArray *KuanShiForShow;

@end

@implementation KuanShiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    _tableView.tableFooterView = [[UITableView alloc]init];
    
    _KuanShiForShow = [NSMutableArray new];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)requestData {
    [_KuanShiForShow removeAllObjects];
    PFQuery *query = [PFQuery queryWithClassName:@"Jibie"];
    [query whereKey:@"info" equalTo:_objectForKS];
    [query includeKey:@"info"];
    self.navigationController.view.userInteractionEnabled = NO;
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        self.navigationController.view.userInteractionEnabled = YES;
        [avi stopAnimating];
        if (!error) {
            NSLog(@"objects = %@",objects);
            
             _KuanShiForShow = [NSMutableArray arrayWithArray:objects];
            [_tableView reloadData];
            
        }else {
            NSLog(@"Error: %@",error.userInfo);
            [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
        }
        
    }];
    
}

//tableView  多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _KuanShiForShow.count;
}
//tableView 的显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KuanShiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *obj = _KuanShiForShow[indexPath.row];
    NSString *kuanshi = obj[@"kuanshi"];
    cell.name.text = kuanshi;
    PFFile *photoFile = obj[@"image"];
    //获取数据库中某个文件的网络路径1
    NSString *photoURLStr = photoFile.url;
    NSURL *photoURL = [NSURL URLWithString:photoURLStr];
    //结合SDWebImage通过图片路径来实现异步加载和缓存（本案中加载到一个图片视图上）
    [cell.image sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"Image-5"]];
    
    PFFile *photoFile2 = obj[@"photo"];
    //获取数据库中某个文件的网络路径1
    NSString *photoURLStr2 = photoFile2.url;
    NSURL *photoURL2 = [NSURL URLWithString:photoURLStr2];
    //结合SDWebImage通过图片路径来实现异步加载和缓存（本案中加载到一个图片视图上）
    [_photoImage sd_setImageWithURL:photoURL2 placeholderImage:[UIImage imageNamed:@"Image-5"]];
    
    
    
    
    
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
    PFObject *obj = _KuanShiForShow[indexPath.row];
    
    CanShuViewController  *cdVC = segue.destinationViewController;
    cdVC.objectForCS = obj;
}


@end
