//
//  XingHaoViewController.m
//  EZCar
//
//  Created by 欧阳 on 16/4/18.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import "XingHaoViewController.h"
#import "XingHaoTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "KuanShiViewController.h"

@interface XingHaoViewController ()
@property(strong,nonatomic) NSMutableArray *xingHaoForShow;


@end

@implementation XingHaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _objectForXH[@"carname"];
    _xingHaoForShow = [NSMutableArray new];
    [self requestData];
    _tableView.tableFooterView = [[UITableView alloc]init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //NSString *objectID = _objectForXH.objectId;
    
}

- (void)requestData {
    [_xingHaoForShow removeAllObjects];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Xinghao"];
    [query whereKey:@"info" equalTo:_objectForXH];
    [query includeKey:@"info"];
    self.navigationController.view.userInteractionEnabled = NO;
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

//tableView  多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _xingHaoForShow.count;
}
//tableView 的显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    XingHaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *obj = _xingHaoForShow[indexPath.row];
    NSString *carxinghao = obj[@"xinghao"];
    cell.name.text = carxinghao;
    PFFile *photoFile = obj[@"carimg"];
    //获取数据库中某个文件的网络路径1
    NSString *photoURLStr = photoFile.url;
    NSURL *photoURL = [NSURL URLWithString:photoURLStr];
    //结合SDWebImage通过图片路径来实现异步加载和缓存（本案中加载到一个图片视图上）
    [cell.image sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"bb"]];
    
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
    PFObject *obj = _xingHaoForShow[indexPath.row];
    
    KuanShiViewController  *cdVC = segue.destinationViewController;
    cdVC.objectForKS = obj;
    
}



@end

