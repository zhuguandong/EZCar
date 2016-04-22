//
//  CanShuViewController.m
//  EZCar
//
//  Created by 欧阳 on 16/4/19.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import "CanShuViewController.h"

@interface CanShuViewController ()

@property (strong, nonatomic) PFObject *object;
@property NSArray *objiectForShow;
@property(strong,nonatomic) NSMutableArray *CanShuForShow;


@end

@implementation CanShuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    self.navigationItem.title = _objectForCS[@"kuanshi"];
    _tableView.allowsSelection = NO;//让tableview不被按
    //[_tableView setSeparatorColor:[UIColor grayColor]];  //设置分割线为蓝色

    _objiectForShow = @[@"品牌",@"厂商报价",@"上市年份",@"变速箱",@"车身结构",@"车型级别",@"排量",@"最大马力",@"变速箱",@"底盘转向",@"驱动方式",@"车体结构",@"助力类型",@"车轮制动",@"前轮胎规格",@"后轮胎规格",@"备胎",@"安全配置",@"驾驶座安全气囊",@"副驾驶安全气囊",@"前排侧气囊",@"后排侧气囊",@"ASB防抱死",@"防盗警报器",@"玻璃/后视镜",@"电动后视镜",@"发动机防盗锁止",@"车内中控锁",@"遥控钥匙",@"疲劳驾驶提示",@"蓝牙/车载电话",@"行李架",];

}
- (void)requestData {
    [_CanShuForShow removeAllObjects];
    PFQuery *query = [PFQuery queryWithClassName:@"CanShu"];
    [query whereKey:@"info" equalTo:_objectForCS];
    [query includeKey:@"info.info.info"];
    self.navigationController.view.userInteractionEnabled = NO;
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        self.navigationController.view.userInteractionEnabled = YES;
        [avi stopAnimating];
        if (!error) {
            NSLog(@"objects = %@",objects);
            _object = objects.firstObject;
            //_CanShuForShow = [NSMutableArray arrayWithArray:objects];
            [_tableView reloadData];
            
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
    static NSString *cellIndentifier=@"Cell";//创建一个静态字符串Cell表示需要复用的细胞名称
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIndentifier];//根据上述名称创建细胞（享元模型）
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    NSString *content=_objiectForShow[indexPath.row];//根据协议条款中indexPath参数可以获得表格中当前正在渲染的细胞的组与行的信息，根据其中的信息可以获得该行在_objiectForShow数组中所对应的文字
    cell.textLabel.text = content;
    
//    NSString *content2=_objiectForShow[indexPath.row];
//        cell.detailTextLabel.text = content2 ;
    switch (indexPath.row) {
        case 0:
            cell.detailTextLabel.text = _object[@"baojia"];
            break;
        case 1:
            cell.detailTextLabel.text = _object[@"info"][@"info"][@"info"][@"carname"];
            break;
        case 2:
            cell.detailTextLabel.text = _object[@"biansuxiang"];
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //按钮取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



@end
