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
#import "KSGuideManager.h"
#import "ShopXQViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "Public.h"
#import "ViewController.h"

#import <ECSlidingViewController/ECSlidingViewController.h>


@interface FirstViewController ()<SDCycleScrollViewDelegate,CLLocationManagerDelegate>{
    BOOL flag;  //用来表示是否已经成功获取到了距离
    BOOL isLoading;
}

@property(strong,nonatomic) NSMutableArray *objectsForShow;
@property(strong, nonatomic) ECSlidingViewController *slidingVC;
@property(strong,nonatomic) CLLocationManager *locationManager;
@property (strong,nonatomic) NSMutableArray *objectForJL;
@property (strong, nonatomic) UIActivityIndicatorView *aiv;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _objectsForShow = [NSMutableArray new];
    _objectForJL = [NSMutableArray new];
    
    //引导页
    NSMutableArray *paths = [NSMutableArray new];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"111" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"222" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"333" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"444" ofType:@"jpg"]];
    [[KSGuideManager shared] showGuideViewWithImages:paths];
   
  
    
    //轮播
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
    
    //下拉刷新
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    rc.tag = 1001;
    rc.tintColor = [UIColor darkGrayColor];
    [rc addTarget:self action:@selector(canToRequestData) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:rc];
    
    //[self refreshData];
    
//    //将是否成功获取距离初始化为NO（没有）
//    flag = NO;
//    _tableView.tableFooterView = [[UITableView alloc]init];
//    //初始化定位管理器
//    _locationManager = [[CLLocationManager alloc]init];
//    //签协议
//    _locationManager.delegate = self;
//    //第一次打开App或者用户致歉没有选择是否要统一使用定位时，询问用户是否同意打开定位
//    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
//#ifdef __IPHONE_8_0
//        //询问用户是否同意当App运行过程中使用定位
//        [_locationManager requestWhenInUseAuthorization];
//#endif
//    }
//    //打开定位开关
//    [_locationManager startUpdatingLocation];
//   
//   //导航条不透明
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    // Dispose of any resources that can be recreated.
}

- (void)refreshData {
    
    isLoading = NO;//刚来到页面进行数据初始化时将“是否正在加载数据”指针设为否
    
    //在根视图上创建一朵菊花，并转动
    _aiv = [Utilities getCoverOnView:self.view];
    [self canToRequestData];
    
    
}

-(void)canToRequestData{
    //只有当加载任务不在进行时，我们才该同意一个新的加载任务
    if (!isLoading ) {
        //当开始执行下拉刷新（包括刚来到页面执行的第一次请求）时将“是否正在加载数据”指针设为是
        
        isLoading = YES;
       
        [self requestData];
    }
}



- (void)requestData {
    PFQuery *query = [PFQuery queryWithClassName:@"Shop"];
    //让导航条失去交互能力
    self.navigationController.view.userInteractionEnabled = NO;
    //在根视图上创建一朵菊花，并转动
    //UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    //查询语句
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        isLoading = NO;
        //根据下标找到刷新器
        UIRefreshControl *rc = (UIRefreshControl *)[_tableView viewWithTag:1001];
        [rc endRefreshing];
        
        //让导航条恢复交互能力
        self.navigationController.view.userInteractionEnabled = YES;
        //停止菊花动画
        [_aiv stopAnimating];
        if (!error) {
            [_objectsForShow removeAllObjects];
            _objectsForShow = [NSMutableArray arrayWithArray:objects];
            NSLog(@"objects = %@",_objectsForShow);
            
            
            [_tableView reloadData];
        }else{
            NSLog(@"Error: %@",error.userInfo);
            [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
        }
    }];
}

//当设备位置更新时，持续调用该方法（定位开关刚打开时也会调用一次
//- (void)locationManager:(CLLocationManager *)manager
//    didUpdateToLocation:(CLLocation *)newLocation
//           fromLocation:(CLLocation *)oldLocation{
//    //newLocation表示设备当前所在位置
//    NSLog(@"latitude %f", newLocation.coordinate.latitude);
//    NSLog(@"longitude %f", newLocation.coordinate.longitude);
//    
//    //当新的位置的经纬度等于旧的位置的经纬度一样时，表示位置基本不变了，这时我们可以停止位置更新
//    if (newLocation.coordinate.latitude == oldLocation.coordinate.latitude && newLocation.coordinate.longitude == oldLocation.coordinate.longitude) {
//        
//        //关闭开始定位的开关
//        [_locationManager stopUpdatingLocation];
//        
//        //创建一个弱指针的自身对象
//        __weak FirstViewController *weakSelf = self;
//        
//        
//        
//        
//        
//        [_objectsForShow removeAllObjects];
//        PFQuery *query = [PFQuery queryWithClassName:@"Shop"];
//        self.navigationController.view.userInteractionEnabled = NO;
//            //在根视图上创建一朵菊花，并转动
//        UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
//        //开始执行查询
//        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
//            self.navigationController.view.userInteractionEnabled = YES;
//                    //停止菊花动画
//            [avi stopAnimating];
//            //判断查询是否出错
//            if (!error) {
//                NSLog(@"Objects = %@",objects);
//                //_objectsForShow = [NSMutableArray arrayWithArray:objects];
//                
//                //当定位成功（拿到自己坐标）并且成功获取餐馆数据后将是否已经成功获取到距离状态设为yes
//                flag = YES;
//                
//                //清空数组操作（避免数组中出现不该有的原始数据）
//                [weakSelf.objectForJL removeAllObjects];
//                //遍历查询语句的结果，从儿可以依次计算每个结果距离用户的距离，将这个距离和其他需要显示在页面还是那个的内容打包放进字典，然后利用循环将这些代表着每一个餐馆的字典收集到一个数组，这个数组就是我们用来匹配tableView页面的数组
//                for (PFObject *obj in objects) {
//                    //得到餐馆的纬度
//                    double latitude = [obj[@"latitude"]doubleValue];
//                    //得到餐馆的经度
//                    double longitude = [obj[@"longitude"]doubleValue];
//                    //初始化一个CLLocation对象，将上面获得的经纬度打包放进去（这个CLLocation对象是为了我们后续计算两点间地球距离而做的准备工作）
//                    CLLocation *resLoc = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
//                    //计算两坐标间距离（该方法为苹果提供的方法，他将会把地球非圆形的球面因素计算在内）
//                    //从newLocation（用户位置）到resLocation（餐馆位置）的距离
//                    double distance =[resLoc distanceFromLocation:newLocation];
//                   
//                    //将餐馆的名称和刚刚我们计算出来的餐馆到我们的位置的距离打包放入一个字典，这样一个字典就代表一个餐馆需要显示在页面上的全部内容
//                    NSDictionary *dict = @{@"name" : obj[@"name"], @"distance" : [NSString stringWithFormat:@"%f",distance]};
//                     NSLog(@"距离＝ %@",dict);
//                    
//                    //将上述表示餐馆的字典收集进objectsForShow数组中（这样当for循环结束时，objectsForShow数组汇总就会有所有的餐馆的信息了）
//                    [weakSelf.objectForJL addObject:dict];
//                    
//                }
//                //当数据获取完成后要重载表格视图
//                [weakSelf.tableView reloadData];
//            } else {
//                NSLog(@"Error : %@",[error userInfo]);
//            }
//        }];
//        
//    }
//}


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
    NSString *quYu = obj[@"quming"];
    cell.juli.text = quYu;
    cell.shopName.text = shopName;
    cell.shopAdress.text = address;
    
    PFFile *photoFile = obj[@"shanghuimg"];
    //获取数据库中某个文件的网络路径1
    NSString *photoURLStr = photoFile.url;
    NSURL *photoURL = [NSURL URLWithString:photoURLStr];
    //结合SDWebImage通过图片路径来实现异步加载和缓存（本案中加载到一个图片视图上）
    [cell.shopImage sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"ee"]];
    
//    NSDictionary *dict = _objectForJL[indexPath.row];
//    //拿到该餐馆的名称
//    //NSString *name = dict[@"name"];
//    //拿到该餐馆和用户的距离
//    NSString *distance = dict[@"distance"];
//    //将餐馆的名称显示在细胞的主标签上（左侧）
//    cell.juli.text = distance;
    
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //按钮取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *indexPath = _tableView.indexPathForSelectedRow;
    //根据上诉行数，获取该行所对应的数据
    PFObject *obj = _objectsForShow[indexPath.row];
    
    ShopXQViewController  *shopVC = segue.destinationViewController;
    shopVC.obj = obj;
    
}

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

- (IBAction)ToSouSuo:(UIButton *)sender forEvent:(UIEvent *)event {
    FirstViewController *tabVC = [Utilities getStoryboardInstance:@"Main" byIdentity:@"SS"];
    [self presentViewController:tabVC animated:YES completion:nil];
}

- (IBAction)chooseAction:(UIBarButtonItem *)sender {
    ViewController *vc = [[ViewController alloc]init];
    
    [vc returnText:^(NSString *cityname) {
        //[_chooseAction setTitle:cityname forState:UIControlStateNormal];
        [_chooseAction setTitle:cityname];
        //_chooseAction.titleLabel.text=cityname;
    }];
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:NO];
}


@end
