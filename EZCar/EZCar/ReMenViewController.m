//
//  ReMenViewController.m
//  EZCar
//
//  Created by 贺先生 on 16/4/23.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import "ReMenViewController.h"
#import "ReMenTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ReMenCSViewController.h"

@interface ReMenViewController ()
@property(strong,nonatomic) NSMutableArray *ReMenForShow;

@end

@implementation ReMenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    _ReMenForShow = [NSMutableArray new];
    _tableview.tableFooterView = [[UITableView alloc]init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)requestData {
    [_ReMenForShow removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"hot = '1'"];
    PFQuery *query = [PFQuery queryWithClassName:@"CanShu" predicate:predicate];
    
    [query includeKey:@"info.info.info"];
    self.navigationController.view.userInteractionEnabled = NO;
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        self.navigationController.view.userInteractionEnabled = YES;
        [avi stopAnimating];
        if (!error) {
            NSLog(@"objects = %@",objects);
            
            _ReMenForShow = [NSMutableArray arrayWithArray:objects];
            [_tableview reloadData];
            
        }else {
            NSLog(@"Error: %@",error.userInfo);
            [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
        }
        
    }];
    
}










//tableView  多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _ReMenForShow.count;
}
//tableView 的显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ReMenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    PFObject *obj = _ReMenForShow[indexPath.row];
    cell.name.text = obj[@"info"][@"info"][@"xinghao"];
    PFFile *photoFile = obj[@"info"][@"info"][@"carimg"];
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
    NSIndexPath *indexPath = _tableview.indexPathForSelectedRow;
    PFObject *obj = _ReMenForShow[indexPath.row];
    
    ReMenCSViewController  *cdVC = segue.destinationViewController;
    cdVC.objectForRM = obj;

}


- (IBAction)Action:(UIButton *)sender forEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
