//
//  FirstViewController.m
//  EZCar
//
//  Created by 欧阳 on 16/4/17.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import "FirstViewController.h"
#import <SDCycleScrollView.h>
#import "FirstTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface FirstViewController ()<UISearchBarDelegate,SDCycleScrollViewDelegate>

@property(strong,nonatomic) NSMutableArray *objectsForShow;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加上 搜索栏
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 35)];//allocate titleView
    UIColor *color =  self.navigationController.navigationBar.barTintColor;
    
    [titleView setBackgroundColor:color];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    
    
    searchBar.delegate = self;
    searchBar.frame = CGRectMake(0, 0, 220, 30);
    searchBar.backgroundColor = color;
    searchBar.layer.cornerRadius = 18;
    searchBar.layer.masksToBounds = YES;
    [searchBar.layer setBorderWidth:8];
    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];  //设置边框为白色
    
    searchBar.placeholder = @"宝马4S店";
    [titleView addSubview:searchBar];
    
    //Set to titleView
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = titleView;
    
    // Do any additional setup after loading the view.
    
//    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Image-22"]];
//    backgroundView.frame = self.view.bounds;
//    [self.view addSubview:backgroundView];
    
    UIScrollView *demoContainerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -64, UI_SCREEN_W, 180 + 64)];
    demoContainerView.contentSize = CGSizeMake(UI_SCREEN_W, 180 + 64);
    
    [_Upview addSubview:demoContainerView];
    
    
    NSArray *imageNames = @[@"aa",@"bb",@"cc", @"dd",@"ee"];
    
    CGFloat w = self.view.bounds.size.width;
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, w, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    cycleScrollView.imageURLStringsGroup = imageNames;
    
    [demoContainerView addSubview:cycleScrollView];
    [self requestData];
    
    _tableView.tableFooterView = [[UITableView alloc]init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    // Dispose of any resources that can be recreated.
}


//tableView  多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objectsForShow.count;
}
//tableView 的显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    PFObject *obj = _objectsForShow[indexPath.row];
    
    NSString *shopName = obj[@"shopname"];
    NSString *address = obj[@"address"];
    cell.shopName.text = shopName;
    cell.shopAdress.text = address;
    PFFile *photoFile = obj[@"shanghuimg"];
    //获取数据库中某个文件的网络路径1
    NSString *photoURLStr = photoFile.url;
    NSURL *photoURL = [NSURL URLWithString:photoURLStr];
    //结合SDWebImage通过图片路径来实现异步加载和缓存（本案中加载到一个图片视图上）
    [cell.shopImage sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"Image"]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //按钮取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)requestData {
    [_objectsForShow removeAllObjects];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Shop"];
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
            _objectsForShow = [NSMutableArray arrayWithArray:objects];
            NSLog(@"objects = %@",_objectsForShow);
            [_tableView reloadData];
        }else{
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
//每次首页出现后
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"EnableGesture" object:nil];
    
}
//每次首页消失后
-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"DisableGesture" object:nil];
}




- (IBAction)menuAction:(UIButton *)sender forEvent:(UIEvent *)event {
     [[NSNotificationCenter defaultCenter] postNotificationName:@"MenuSwitch" object:nil];
}
@end
