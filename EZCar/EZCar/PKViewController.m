//
//  PKViewController.m
//  EZCar
//
//  Created by 欧阳 on 16/4/24.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import "PKViewController.h"
#import "PKTableViewCell.h"

@interface PKViewController ()
@property NSArray *objiectForShow;
@property (strong, nonatomic) PFObject *object1;
@property (strong, nonatomic) PFObject *object2;
@property (strong, nonatomic) PFObject *object3;
@property (strong, nonatomic) PFObject *object4;
@property (strong, nonatomic) PFObject *object5;


//@property(strong,nonatomic) NSString *c1;





@end

@implementation PKViewController
-(void)removeAll{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier]; [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
     NSLog(@"清空被按了");
    
    _object1 = nil;
    _object2 = nil;
    _object3 = nil;
    _object4 = nil;
    _object5 = nil;
    _car1Name.text = nil;
    _car2Name.text = nil;
    _car3Name.text = nil;
    _car4Name.text = nil;
    _car5Name.text = nil;
    [_tableview reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableview.allowsSelection = NO;//让tableview不被按
    
    _objiectForShow = @[@"品牌",@"厂商报价",@"上市年份",@"变速箱",@"车身结构",@"车型级别",@"排量",@"最大马力",@"油耗",@"燃料形式",@"驱动方式",@"进气形式",@"助力类型",@"前悬架类型",@"前轮胎规格",@"后轮胎规格",@"备胎规格",@"后悬架类型",@"主/副驾驶安全气囊",@"前/后排头部气囊(气帘)",@"前制动器类型",@"整车质保",@"ASB防抱死",@"方向盘调节",@"最大扭矩转速(rpm)",@"配气机构",@"行李厢容积(L)",@"长*宽*高(mm)",@"发动机",@"供油方式",@"座椅材质",@"环保标准",];
    PFUser *currentUser = [PFUser currentUser];
    NSLog(@"currentUser = %@", currentUser);
    if (currentUser) {
        [self show];
        
        
    }
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(removeAll) name:@"removeAll" object:nil];
    
    
    
   
    
   
}

-(void)show {
    
    NSUserDefaults * userDefaultes = [NSUserDefaults standardUserDefaults];
    NSMutableArray * mutableArray = [NSMutableArray arrayWithArray:[userDefaultes objectForKey:@"myArray"]];
    NSLog(@"arr = %@",mutableArray);
    
    NSArray *qq = [NSArray arrayWithArray:mutableArray];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:qq forKey:@"yuan"];
    [userDefaults synchronize];
    
    

    
    if (mutableArray.count == 0) {
        
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"空空的！" message:@"您可以前往 首页->菜单->对比收藏 添加对比车辆哦～" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"朕知晓" style:UIAlertActionStyleCancel handler:nil];
        
        [alertView addAction:ok];
        
        [self presentViewController:alertView animated:YES completion:nil];
        
    }
    
    if (mutableArray.count == 2) {
        
       NSString *c1 = mutableArray[0];
        _car1Name.text = c1;
         NSString *c2 = mutableArray[1];
        _car2Name.text = c2;
        NSUserDefaults *userDefaults1 = [NSUserDefaults standardUserDefaults];
        [userDefaults1 setObject:c1 forKey:@"car1Name"];
        //NSUserDefaults *userDefaults2 = [NSUserDefaults standardUserDefaults];
        [userDefaults1 setObject:c2 forKey:@"car2Name"];
        
        [userDefaults1 synchronize];
        //[userDefaults2 synchronize];
        [self requestData1];
        [self requestData2];
        
    }
    if (mutableArray.count == 3) {
        
        NSString *c1 = mutableArray[0];
        _car1Name.text = c1;
        NSString *c2 = mutableArray[1];
        _car2Name.text = c2;
        NSString *c3 = mutableArray[2];
        _car3Name.text = c3;
        NSUserDefaults *userDefaults1 = [NSUserDefaults standardUserDefaults];
        [userDefaults1 setObject:c1 forKey:@"car1Name"];
        //NSUserDefaults *userDefaults2 = [NSUserDefaults standardUserDefaults];
        [userDefaults1 setObject:c2 forKey:@"car2Name"];
        //NSUserDefaults *userDefaults3 = [NSUserDefaults standardUserDefaults];
        [userDefaults1 setObject:c3 forKey:@"car3Name"];
        
        [userDefaults1 synchronize];
        //[userDefaults2 synchronize];
        //[userDefaults3 synchronize];

        [self requestData1];
        [self requestData2];
        [self requestData3];
    }
    if (mutableArray.count == 4) {
        
        NSString *c1 = mutableArray[0];
        _car1Name.text = c1;
        NSString *c2 = mutableArray[1];
        _car2Name.text = c2;
        NSString *c3 = mutableArray[2];
        _car3Name.text = c3;
        NSString *c4 = mutableArray[3];
        _car4Name.text = c4;
        NSUserDefaults *userDefaults1 = [NSUserDefaults standardUserDefaults];
        [userDefaults1 setObject:c1 forKey:@"car1Name"];
        //NSUserDefaults *userDefaults2 = [NSUserDefaults standardUserDefaults];
        [userDefaults1 setObject:c2 forKey:@"car2Name"];
        //NSUserDefaults *userDefaults3 = [NSUserDefaults standardUserDefaults];
        [userDefaults1 setObject:c3 forKey:@"car3Name"];
        [userDefaults1 setObject:c4 forKey:@"car4Name"];
        
        [userDefaults1 synchronize];
        //[userDefaults2 synchronize];
        //[userDefaults3 synchronize];
        
        [self requestData1];
        [self requestData2];
        [self requestData3];
        [self requestData4];
        
    }
    if (mutableArray.count == 5) {
        
        NSString *c1 = mutableArray[0];
        _car1Name.text = c1;
        NSString *c2 = mutableArray[1];
        _car2Name.text = c2;
        NSString *c3 = mutableArray[2];
        _car3Name.text = c3;
        NSString *c4 = mutableArray[3];
        _car4Name.text = c4;
        NSString *c5 = mutableArray[4];
        _car5Name.text = c5;
        
        NSUserDefaults *userDefaults1 = [NSUserDefaults standardUserDefaults];
        [userDefaults1 setObject:c1 forKey:@"car1Name"];
        //NSUserDefaults *userDefaults2 = [NSUserDefaults standardUserDefaults];
        [userDefaults1 setObject:c2 forKey:@"car2Name"];
        //NSUserDefaults *userDefaults3 = [NSUserDefaults standardUserDefaults];
        [userDefaults1 setObject:c3 forKey:@"car3Name"];
        [userDefaults1 setObject:c4 forKey:@"car4Name"];
        [userDefaults1 setObject:c5 forKey:@"car5Name"];
        
        [userDefaults1 synchronize];
        //[userDefaults2 synchronize];
        //[userDefaults3 synchronize];
        
        [self requestData1];
        [self requestData2];
        [self requestData3];
        [self requestData4];
        [self requestData5];
        
    }
    
    
    //清空UserDefaults
   // NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier]; [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    
    
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    PFUser *currentUser = [PFUser currentUser];
    NSLog(@"currentUser = %@", currentUser);
    if (currentUser) {
        [self show];
        
        
    }
    
    


}

- (void)requestData1 {
    NSUserDefaults * userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *car1Name = [userDefaultes stringForKey:@"car1Name"];
    NSLog(@"-------->%@",car1Name);
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"xinghao = %@",car1Name];
    
    
  
    PFQuery *query = [PFQuery queryWithClassName:@"CanShu" predicate:predicate];
    [query includeKey:@"info.info.info"];
    
    self.navigationController.view.userInteractionEnabled = NO;
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        self.navigationController.view.userInteractionEnabled = YES;
        [avi stopAnimating];
        if (!error) {
            NSLog(@"objects = %@",objects);
            
            _object1 = objects.firstObject;
            [_tableview reloadData];
            
        }else {
            NSLog(@"Error: %@",error.userInfo);
            [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
        }
        
    }];
    
}
- (void)requestData2 {
    
    NSUserDefaults * userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *car2Name = [userDefaultes stringForKey:@"car2Name"];
    NSLog(@"-------->%@",car2Name);
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"xinghao = %@",car2Name];
    PFQuery *query = [PFQuery queryWithClassName:@"CanShu" predicate:predicate];
    [query includeKey:@"info.info.info"];
    
    self.navigationController.view.userInteractionEnabled = NO;
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        self.navigationController.view.userInteractionEnabled = YES;
        [avi stopAnimating];
        if (!error) {
            NSLog(@"objects = %@",objects);
            
            _object2 = objects.firstObject;
            [_tableview reloadData];
            
        }else {
            NSLog(@"Error: %@",error.userInfo);
            [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
        }
        
    }];
    
}
- (void)requestData3 {
    NSUserDefaults * userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *car3Name = [userDefaultes stringForKey:@"car3Name"];
    NSLog(@"-------->%@",car3Name);
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"xinghao = %@",car3Name];
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"CanShu" predicate:predicate];
    [query includeKey:@"info.info.info"];
    
    self.navigationController.view.userInteractionEnabled = NO;
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        self.navigationController.view.userInteractionEnabled = YES;
        [avi stopAnimating];
        if (!error) {
            NSLog(@"objects = %@",objects);
            
            _object3 = objects.firstObject;
            [_tableview reloadData];
            
        }else {
            NSLog(@"Error: %@",error.userInfo);
            [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
        }
        
    }];
    
}
- (void)requestData4 {
    NSUserDefaults * userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *car4Name = [userDefaultes stringForKey:@"car4Name"];
    NSLog(@"-------->%@",car4Name);
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"xinghao = %@",car4Name];
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"CanShu" predicate:predicate];
    [query includeKey:@"info.info.info"];
    
    self.navigationController.view.userInteractionEnabled = NO;
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        self.navigationController.view.userInteractionEnabled = YES;
        [avi stopAnimating];
        if (!error) {
            NSLog(@"objects = %@",objects);
            
            _object4 = objects.firstObject;
            [_tableview reloadData];
            
        }else {
            NSLog(@"Error: %@",error.userInfo);
            [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
        }
        
    }];
    
}
- (void)requestData5 {
    NSUserDefaults * userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *car5Name = [userDefaultes stringForKey:@"car5Name"];
    NSLog(@"-------->%@",car5Name);
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"xinghao = %@",car5Name];
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"CanShu" predicate:predicate];
    [query includeKey:@"info.info.info"];
    
    self.navigationController.view.userInteractionEnabled = NO;
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        self.navigationController.view.userInteractionEnabled = YES;
        [avi stopAnimating];
        if (!error) {
            NSLog(@"objects = %@",objects);
            
            _object5 = objects.firstObject;
            [_tableview reloadData];
            
        }else {
            NSLog(@"Error: %@",error.userInfo);
            [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
        }
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//tableView  多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objiectForShow.count;
}
//tableView 的显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
            cell.name.text = _objiectForShow[0];
            break;
        case 1:
            cell.name.text = _objiectForShow[1];
            break;
        case 2:
            cell.name.text = _objiectForShow[2];
            break;
        case 3:
            cell.name.text = _objiectForShow[3];
            break;
        case 4:
            cell.name.text = _objiectForShow[4];
            break;
        case 5:
            cell.name.text = _objiectForShow[5];
            break;
        case 6:
            cell.name.text = _objiectForShow[6];
            break;
        case 7:
            cell.name.text = _objiectForShow[7];
            break;
        case 8:
            cell.name.text = _objiectForShow[8];
            break;
        case 9:
            cell.name.text = _objiectForShow[9];
            break;
        case 10:
            cell.name.text = _objiectForShow[10];
            break;
        case 11:
            cell.name.text = _objiectForShow[11];
            break;
        case 12:
            cell.name.text = _objiectForShow[12];
            break;
        case 13:
            cell.name.text = _objiectForShow[13];
            break;
        case 14:
            cell.name.text = _objiectForShow[14];
            break;
        case 15:
            cell.name.text = _objiectForShow[15];
            break;
        case 16:
            cell.name.text = _objiectForShow[16];
            break;
        case 17:
            cell.name.text = _objiectForShow[17];
            break;
        case 18:
            cell.name.text = _objiectForShow[18];
            break;
        case 19:
            cell.name.text = _objiectForShow[19];
            break;
        case 20:
            cell.name.text = _objiectForShow[20];
            break;
        case 21:
            cell.name.text = _objiectForShow[21];
            break;
        case 22:
            cell.name.text = _objiectForShow[22];
            break;
        case 23:
            cell.name.text = _objiectForShow[23];
            break;
        case 24:
            cell.name.text = _objiectForShow[24];
            break;
        case 25:
            cell.name.text = _objiectForShow[25];
            break;
        case 26:
            cell.name.text = _objiectForShow[26];
            break;
        case 27:
            cell.name.text = _objiectForShow[27];
            break;
        case 28:
            cell.name.text = _objiectForShow[28];
            break;
        case 29:
            cell.name.text = _objiectForShow[29];
            break;
        case 30:
            cell.name.text = _objiectForShow[30];
            break;
        case 31:
            cell.name.text = _objiectForShow[31];
            break;
        case 32:
            cell.name.text = _objiectForShow[32];
            break;
            
            
        default:
            break;
    }
    
    
    switch (indexPath.row) {
        case 0:
            cell.car1CS.text = _object1[@"info"][@"info"][@"info"][@"carname"];;
            break;
        case 1:
            cell.car1CS.text = _object1[@"a2"];
            break;
        case 2:
            cell.car1CS.text = _object1[@"a3"];
            break;
        case 3:
            cell.car1CS.text = _object1[@"a4"];
            break;
        case 4:
            cell.car1CS.text = _object1[@"a5"];
            break;
        case 5:
            cell.car1CS.text = _object1[@"a6"];
            break;
        case 6:
            cell.car1CS.text = _object1[@"a7"];
            break;
        case 7:
            cell.car1CS.text = _object1[@"a8"];
            break;
        case 8:
            cell.car1CS.text = _object1[@"a9"];
            break;
        case 9:
            cell.car1CS.text = _object1[@"a10"];
            break;
        case 10:
            cell.car1CS.text = _object1[@"a11"];
            break;
        case 11:
            cell.car1CS.text = _object1[@"a12"];
            break;
        case 12:
            cell.car1CS.text = _object1[@"a13"];
            break;
        case 13:
            cell.car1CS.text = _object1[@"a14"];
            break;
        case 14:
            cell.car1CS.text = _object1[@"a15"];
            break;
        case 15:
            cell.car1CS.text = _object1[@"a16"];
            break;
        case 16:
            cell.car1CS.text = _object1[@"a17"];
            break;
        case 17:
            cell.car1CS.text = _object1[@"a18"];
            break;
        case 18:
            cell.car1CS.text = _object1[@"a19"];
            break;
        case 19:
            cell.car1CS.text = _object1[@"a20"];
            break;
        case 20:
            cell.car1CS.text = _object1[@"a21"];
            break;
        case 21:
            cell.car1CS.text = _object1[@"a22"];
            break;
        case 22:
            cell.car1CS.text = _object1[@"a23"];
            break;
        case 23:
            cell.car1CS.text = _object1[@"a24"];
            break;
        case 24:
            cell.car1CS.text = _object1[@"a25"];
            break;
        case 25:
            cell.car1CS.text = _object1[@"a26"];
            break;
        case 26:
            cell.car1CS.text = _object1[@"a27"];
            break;
        case 27:
            cell.car1CS.text = _object1[@"a28"];
            break;
        case 28:
            cell.car1CS.text = _object1[@"a29"];
            break;
        case 29:
            cell.car1CS.text = _object1[@"a30"];
            break;
        case 30:
            cell.car1CS.text = _object1[@"a31"];
            break;
        case 31:
            cell.car1CS.text = _object1[@"a32"];
            break;
        case 32:
            cell.car1CS.text = _object1[@"a33"];
            break;
            
            
        default:
            break;
    }
    switch (indexPath.row) {
        case 0:
            cell.car2CS.text = _object2[@"info"][@"info"][@"info"][@"carname"];
            break;
        case 1:
            cell.car2CS.text = _object2[@"a2"];
            break;
        case 2:
            cell.car2CS.text = _object2[@"a3"];
            break;
        case 3:
            cell.car2CS.text = _object2[@"a4"];
            break;
        case 4:
            cell.car2CS.text = _object2[@"a5"];
            break;
        case 5:
            cell.car2CS.text = _object2[@"a6"];
            break;
        case 6:
            cell.car2CS.text = _object2[@"a7"];
            break;
        case 7:
            cell.car2CS.text = _object2[@"a8"];
            break;
        case 8:
            cell.car2CS.text = _object2[@"a9"];
            break;
        case 9:
            cell.car2CS.text = _object2[@"a10"];
            break;
        case 10:
            cell.car2CS.text = _object2[@"a11"];
            break;
        case 11:
            cell.car2CS.text = _object2[@"a12"];
            break;
        case 12:
            cell.car2CS.text = _object2[@"a13"];
            break;
        case 13:
            cell.car2CS.text = _object2[@"a14"];
            break;
        case 14:
            cell.car2CS.text = _object2[@"a15"];
            break;
        case 15:
            cell.car2CS.text = _object2[@"a16"];
            break;
        case 16:
            cell.car2CS.text = _object2[@"a17"];
            break;
        case 17:
            cell.car2CS.text = _object2[@"a18"];
            break;
        case 18:
            cell.car2CS.text = _object2[@"a19"];
            break;
        case 19:
            cell.car2CS.text = _object2[@"a20"];
            break;
        case 20:
            cell.car2CS.text = _object2[@"a21"];
            break;
        case 21:
            cell.car2CS.text = _object2[@"a22"];
            break;
        case 22:
            cell.car2CS.text = _object2[@"a23"];
            break;
        case 23:
            cell.car2CS.text = _object2[@"a24"];
            break;
        case 24:
            cell.car2CS.text = _object2[@"a25"];
            break;
        case 25:
            cell.car2CS.text = _object2[@"a26"];
            break;
        case 26:
            cell.car2CS.text = _object2[@"a27"];
            break;
        case 27:
            cell.car2CS.text = _object2[@"a28"];
            break;
        case 28:
            cell.car2CS.text = _object2[@"a29"];
            break;
        case 29:
            cell.car2CS.text = _object2[@"a30"];
            break;
        case 30:
            cell.car2CS.text = _object2[@"a31"];
            break;
        case 31:
            cell.car2CS.text = _object2[@"a32"];
            break;
        case 32:
            cell.car2CS.text = _object2[@"a33"];
            break;
            
            
        default:
        break;
    }
    switch (indexPath.row) {
        case 0:
            cell.car3CS.text = _object3[@"info"][@"info"][@"info"][@"carname"];
            break;
        case 1:
            cell.car3CS.text = _object3[@"a2"];
            break;
        case 2:
            cell.car3CS.text = _object3[@"a3"];
            break;
        case 3:
            cell.car3CS.text = _object3[@"a4"];
            break;
        case 4:
            cell.car3CS.text = _object3[@"a5"];
            break;
        case 5:
            cell.car3CS.text = _object3[@"a6"];
            break;
        case 6:
            cell.car3CS.text = _object3[@"a7"];
            break;
        case 7:
            cell.car3CS.text = _object3[@"a8"];
            break;
        case 8:
            cell.car3CS.text = _object3[@"a9"];
            break;
        case 9:
            cell.car3CS.text = _object3[@"a10"];
            break;
        case 10:
            cell.car3CS.text = _object3[@"a11"];
            break;
        case 11:
            cell.car3CS.text = _object3[@"a12"];
            break;
        case 12:
            cell.car3CS.text = _object3[@"a13"];
            break;
        case 13:
            cell.car3CS.text = _object3[@"a14"];
            break;
        case 14:
            cell.car3CS.text = _object3[@"a15"];
            break;
        case 15:
            cell.car3CS.text = _object3[@"a16"];
            break;
        case 16:
            cell.car3CS.text = _object3[@"a17"];
            break;
        case 17:
            cell.car3CS.text = _object3[@"a18"];
            break;
        case 18:
            cell.car3CS.text = _object3[@"a19"];
            break;
        case 19:
            cell.car3CS.text = _object3[@"a20"];
            break;
        case 20:
            cell.car3CS.text = _object3[@"a21"];
            break;
        case 21:
            cell.car3CS.text = _object3[@"a22"];
            break;
        case 22:
            cell.car3CS.text = _object3[@"a23"];
            break;
        case 23:
            cell.car3CS.text = _object3[@"a24"];
            break;
        case 24:
            cell.car3CS.text = _object3[@"a25"];
            break;
        case 25:
            cell.car3CS.text = _object3[@"a26"];
            break;
        case 26:
            cell.car3CS.text = _object3[@"a27"];
            break;
        case 27:
            cell.car3CS.text = _object3[@"a28"];
            break;
        case 28:
            cell.car3CS.text = _object3[@"a29"];
            break;
        case 29:
            cell.car3CS.text = _object3[@"a30"];
            break;
        case 30:
            cell.car3CS.text = _object3[@"a31"];
            break;
        case 31:
            cell.car3CS.text = _object3[@"a32"];
            break;
        case 32:
            cell.car3CS.text = _object3[@"a33"];
            break;
            
            
        default:
            break;
    }
    switch (indexPath.row) {
        case 0:
            cell.car4CS.text = _object4[@"info"][@"info"][@"info"][@"carname"];
            break;
        case 1:
            cell.car4CS.text = _object4[@"a2"];
            break;
        case 2:
            cell.car4CS.text = _object4[@"a3"];
            break;
        case 3:
            cell.car4CS.text = _object4[@"a4"];
            break;
        case 4:
            cell.car4CS.text = _object4[@"a5"];
            break;
        case 5:
            cell.car4CS.text = _object4[@"a6"];
            break;
        case 6:
            cell.car4CS.text = _object4[@"a7"];
            break;
        case 7:
            cell.car4CS.text = _object4[@"a8"];
            break;
        case 8:
            cell.car4CS.text = _object4[@"a9"];
            break;
        case 9:
            cell.car4CS.text = _object4[@"a10"];
            break;
        case 10:
            cell.car4CS.text = _object4[@"a11"];
            break;
        case 11:
            cell.car4CS.text = _object4[@"a12"];
            break;
        case 12:
            cell.car4CS.text = _object4[@"a13"];
            break;
        case 13:
            cell.car4CS.text = _object4[@"a14"];
            break;
        case 14:
            cell.car4CS.text = _object4[@"a15"];
            break;
        case 15:
            cell.car4CS.text = _object4[@"a16"];
            break;
        case 16:
            cell.car4CS.text = _object4[@"a17"];
            break;
        case 17:
            cell.car4CS.text = _object4[@"a18"];
            break;
        case 18:
            cell.car4CS.text = _object4[@"a19"];
            break;
        case 19:
            cell.car4CS.text = _object4[@"a20"];
            break;
        case 20:
            cell.car4CS.text = _object4[@"a21"];
            break;
        case 21:
            cell.car4CS.text = _object4[@"a22"];
            break;
        case 22:
            cell.car4CS.text = _object4[@"a23"];
            break;
        case 23:
            cell.car4CS.text = _object4[@"a24"];
            break;
        case 24:
            cell.car4CS.text = _object4[@"a25"];
            break;
        case 25:
            cell.car4CS.text = _object4[@"a26"];
            break;
        case 26:
            cell.car4CS.text = _object4[@"a27"];
            break;
        case 27:
            cell.car4CS.text = _object4[@"a28"];
            break;
        case 28:
            cell.car4CS.text = _object4[@"a29"];
            break;
        case 29:
            cell.car4CS.text = _object4[@"a30"];
            break;
        case 30:
            cell.car4CS.text = _object4[@"a31"];
            break;
        case 31:
            cell.car4CS.text = _object4[@"a32"];
            break;
        case 32:
            cell.car4CS.text = _object4[@"a33"];
            break;
            
            
        default:
            break;
    }
    switch (indexPath.row) {
        case 0:
            cell.car5CS.text = _object5[@"info"][@"info"][@"info"][@"carname"];
            break;
        case 1:
            cell.car5CS.text = _object5[@"a2"];
            break;
        case 2:
            cell.car5CS.text = _object5[@"a3"];
            break;
        case 3:
            cell.car5CS.text = _object5[@"a4"];
            break;
        case 4:
            cell.car5CS.text = _object5[@"a5"];
            break;
        case 5:
            cell.car5CS.text = _object5[@"a6"];
            break;
        case 6:
            cell.car5CS.text = _object5[@"a7"];
            break;
        case 7:
            cell.car5CS.text = _object5[@"a8"];
            break;
        case 8:
            cell.car5CS.text = _object5[@"a9"];
            break;
        case 9:
            cell.car5CS.text = _object5[@"a10"];
            break;
        case 10:
            cell.car5CS.text = _object5[@"a11"];
            break;
        case 11:
            cell.car5CS.text = _object5[@"a12"];
            break;
        case 12:
            cell.car5CS.text = _object5[@"a13"];
            break;
        case 13:
            cell.car5CS.text = _object5[@"a14"];
            break;
        case 14:
            cell.car5CS.text = _object5[@"a15"];
            break;
        case 15:
            cell.car5CS.text = _object5[@"a16"];
            break;
        case 16:
            cell.car5CS.text = _object5[@"a17"];
            break;
        case 17:
            cell.car5CS.text = _object5[@"a18"];
            break;
        case 18:
            cell.car5CS.text = _object5[@"a19"];
            break;
        case 19:
            cell.car5CS.text = _object5[@"a20"];
            break;
        case 20:
            cell.car5CS.text = _object5[@"a21"];
            break;
        case 21:
            cell.car5CS.text = _object5[@"a22"];
            break;
        case 22:
            cell.car5CS.text = _object5[@"a23"];
            break;
        case 23:
            cell.car5CS.text = _object5[@"a24"];
            break;
        case 24:
            cell.car5CS.text = _object5[@"a25"];
            break;
        case 25:
            cell.car5CS.text = _object5[@"a26"];
            break;
        case 26:
            cell.car5CS.text = _object5[@"a27"];
            break;
        case 27:
            cell.car5CS.text = _object5[@"a28"];
            break;
        case 28:
            cell.car5CS.text = _object5[@"a29"];
            break;
        case 29:
            cell.car5CS.text = _object5[@"a30"];
            break;
        case 30:
            cell.car5CS.text = _object5[@"a31"];
            break;
        case 31:
            cell.car5CS.text = _object5[@"a32"];
            break;
        case 32:
            cell.car5CS.text = _object5[@"a33"];
            break;
            
            
        default:
            break;
    }
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}
    
 


- (IBAction)清空:(UIBarButtonItem *)sender {
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier]; [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [self show];
    _object1 = nil;
    _object2 = nil;
    _object3 = nil;
    _object4 = nil;
    _object5 = nil;
    _car1Name.text = nil;
    _car2Name.text = nil;
    _car3Name.text = nil;
    _car4Name.text = nil;
    _car5Name.text = nil;
    
    
    [_tableview reloadData];
}

    //NSLog(@"清空被按了");
    //[[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(清空:) name:@"removeAll" object:nil];



@end
