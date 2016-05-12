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
//@property(strong,nonatomic) NSString *c1;





@end

@implementation PKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableview.allowsSelection = NO;//让tableview不被按
    
    _objiectForShow = @[@"品牌",@"厂商报价",@"上市年份",@"变速箱",@"车身结构",@"车型级别",@"排量",@"最大马力",@"油耗",@"燃料形式",@"驱动方式",@"进气形式",@"助力类型",@"前悬架类型",@"前轮胎规格",@"后轮胎规格",@"备胎规格",@"后悬架类型",@"主/副驾驶安全气囊",@"前/后排头部气囊(气帘)",@"前制动器类型",@"整车质保",@"ASB防抱死",@"方向盘调节",@"最大扭矩转速(rpm)",@"配气机构",@"行李厢容积(L)",@"长*宽*高(mm)",@"发动机",@"供油方式",@"座椅材质",@"环保标准",];
    [self show];
    
   
    
   
}
-(void)show {
    
    NSUserDefaults * userDefaultes = [NSUserDefaults standardUserDefaults];
    NSMutableArray * mutableArray = [NSMutableArray arrayWithArray:[userDefaultes objectForKey:@"myArray"]];
    NSLog(@"arr = %@",mutableArray);
    if (mutableArray.count == 0) {
        
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"空空如也！\n您可以前往 首页->菜单->对比收藏 添加对比车辆哦～" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"朕知晓" style:UIAlertActionStyleCancel handler:nil];
        
        [alertView addAction:ok];
        
        [self presentViewController:alertView animated:YES completion:nil];
        
    }
    
    if (mutableArray.count == 2) {
        
       NSString *c1 = mutableArray[0];
        _car1Name.text = c1;
         NSString *c2 = mutableArray[1];
        _car2Name.text = c2;
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
        
    }
    
    //清空UserDefaults
   // NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier]; [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    
    
    
}
-(void)viewDidAppear:(BOOL)animated {
    [self show];
}

- (void)requestData1 {
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"hot = '20'"];
    
  
    PFQuery *query = [PFQuery queryWithClassName:@"CanShu" predicate:predicate];
    
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
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"hot = '20'"];
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"CanShu" predicate:predicate];
    
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
            cell.car1CS.text = _object1[@"canshu"][@"info"][@"info"][@"carname"];
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
            cell.car1CS.text = _object[@"a28"];
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
            cell.car2CS.text = _object2[@"canshu"][@"info"][@"info"][@"carname"];
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
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}
    
 


- (IBAction)清空:(UIBarButtonItem *)sender {
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier]; [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [self show];
    _object1 = nil;
    _object2 = nil;
    _car1Name.text = @" ";
    _car2Name.text = @" ";
    _car3Name.text = @" ";
    _car4Name.text = @" ";
    _car5Name.text = @" ";
    
    
    [_tableview reloadData];
}

@end
