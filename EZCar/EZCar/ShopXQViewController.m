//
//  ShopXQViewController.m
//  EZCar
//
//  Created by fang on 16/4/22.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import "ShopXQViewController.h"
#import "FirstTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ShopXQTableViewCell.h"
#import "ShopCSViewController.h"

@interface ShopXQViewController ()

@property(strong,nonatomic) NSMutableArray *objectsForShow;

@end

@implementation ShopXQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _tableView.tableFooterView = [[UITableView alloc]init];
     //Do any additional setup after loading the view.
    NSString *shopName =_obj[@"shopname"];
    NSString *shopAdress = _obj[@"address"];
    NSString *shopPhone = _obj[@"tel"];
    NSString *miaoShu = _obj[@"describe"];
    _shopName.text = [NSString stringWithFormat:@"店名: %@",shopName];
    _shopAdress.text = [NSString stringWithFormat:@"地址:%@",shopAdress];;
    _shopPhone.text = [NSString stringWithFormat:@"联系电话:%@",shopPhone];;
    _miaoShu.text = [NSString stringWithFormat:@"描述:%@",miaoShu];;
    
    PFFile *photoFile = _obj[@"shanghuimg"];
    //获取数据库中某个文件的网络路径1
    NSString *photoURLStr = photoFile.url;
    NSURL *photoURL = [NSURL URLWithString:photoURLStr];
    //结合SDWebImage通过图片路径来实现异步加载和缓存（本案中加载到一个图片视图上）
    [_shopImage sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"ee"]];
    
    [self requestData];
    
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
    ShopXQTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    PFObject *obj = _objectsForShow[indexPath.row];
    
    NSString *carName = obj[@"info"][@"kuanshi"];
    cell.carName.text = carName;
    
    PFFile *photoFile = obj[@"info"][@"image"];
    //获取数据库中某个文件的网络路径1
    NSString *photoURLStr = photoFile.url;
    NSURL *photoURL = [NSURL URLWithString:photoURLStr];
    //结合SDWebImage通过图片路径来实现异步加载和缓存（本案中加载到一个图片视图上）
    [cell.carImage sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"ee"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //按钮取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)requestData {
    [_objectsForShow removeAllObjects];
    
    PFQuery *query = [PFQuery queryWithClassName:@"CanShu"];
    [query whereKey:@"Info" equalTo:_obj];
    [query includeKey:@"info.info.info"];
    
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


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
        NSIndexPath *indexPath = _tableView.indexPathForSelectedRow;
    PFObject *obj = _objectsForShow[indexPath.row];
    
     ShopCSViewController *csVC = segue.destinationViewController;
    csVC.objectForCS = obj;
    
}


- (IBAction)dialAction:(UIButton *)sender forEvent:(UIEvent *)event {
    NSString *phone = [self subString:_shopPhone.text fromCharacter:@":"];
    NSLog(@"phone = %@",phone);
    //该地址字符串将实现先询问是否拨打电话再根据用户的选择去拨打或取消拨打
    NSString *dailStr= [NSString stringWithFormat:@"telprompt://%@",phone];
    //将字符串转换成NSURl对象
    NSURL *dialURL = [NSURL URLWithString:dailStr];
    //用openURL方法执行这个链接点调用（这里是通话功能的调用）
    [[UIApplication sharedApplication]openURL:dialURL];
}

//从string这个字符串内根据character字符去截取string中character之后的部分（不包含character的值）
-(NSString *)subString:(NSString *)string fromCharacter:(NSString *)character {
    NSString *result = nil;
    //获取string字符串中character字符的位置
    NSRange range = [string rangeOfString:character];
    //判断range是否存在（判断string中如果包含character）
    if (range.location != NSNotFound) {
        //从character的range获得character之后部分的位置，然后根据这个位置截取这个之后部分
        result = [string substringFromIndex:(range.location + range.length)];
    }
    
    return result;
}

@end
