//
//  CanShuViewController.m
//  EZCar
//
//  Created by 欧阳 on 16/4/19.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import "CanShuViewController.h"

@interface CanShuViewController ()
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

    _objiectForShow = @[@"厂商报价",@"品牌",@"变速箱",@"车身结构",@"上市年份",@"车型级别",@"品牌",@"排量",@"最大马力",@"燃料形式",@"环保标准",@"变速箱",@"底盘转向",@"驱动方式",@"车体结构",@"助力类型",@"车轮制动",@"前轮胎规格",@"后轮胎规格",@"备胎",@"安全配置",@"驾驶座安全气囊",@"副驾驶安全气囊",@"前排侧气囊",@"后排侧气囊",@"行人安全气囊",@"儿童座接口",@"胎压监测装置",@"零胎压继续行驶",@"安全带未系提醒",@"防盗警报器",@"发动机防盗锁止",@"车内中控锁",@"遥控钥匙",@"疲劳驾驶提示",@"夜视系统",@"操控配置",@"ASB防抱死",@"上坡辅助",@"陡坡缓降",@"自动驻车",@"并线辅助",@"可变悬架",@"可变转向性",@"外部配置",@"天窗",@"全景天窗",@"电动侧滑门",@"电动吸合门",@"行李架",@"主动格栅",@"电动后备箱",@"内部配置",@"真皮方向盘",@"方向盘前后调节",@"方向盘上下调节",@"多功能方向盘",@"换挡拨片",@"泊车辅助",@"倒车视频影像",@"全景摄像头",@"定速巡航",@"座椅配置",@"真皮/仿皮座椅",@"运动风格座椅",@"驾驶座电动调节",@"座椅高低调节",@"多媒体配置",@"GPS导航系统",@"蓝牙/车载电话",@"语音控制系统",@"车载电视",@"灯光配置",@"疝气大灯",@"LED大灯",@"激光大灯",@"前雾灯",@"后雾灯",@"日间行车灯",@"自动头灯",@"玻璃/后视镜",@"前电动车窗",@"后电动车窗",@"电动后视镜",@"雨量适应雨刷",@"后雨刷",@"空调/冰箱",@"手动空调",@"自动空调",@"后排独立空调",@"后排出风口",@"温度分区控制",@"车载冰箱",@"其他",@"说明",];

}
- (void)requestData {
    [_CanShuForShow removeAllObjects];
    PFQuery *query = [PFQuery queryWithClassName:@"CanShu"];
    [query whereKey:@"info" equalTo:_objectForCS];
    [query includeKey:@"info"];
    self.navigationController.view.userInteractionEnabled = NO;
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        self.navigationController.view.userInteractionEnabled = YES;
        [avi stopAnimating];
        if (!error) {
            NSLog(@"objects = %@",objects);
            
            _CanShuForShow = [NSMutableArray arrayWithArray:objects];
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
    
    NSString *content2=_objiectForShow[indexPath.row];
        cell.detailTextLabel.text = content2 ;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //按钮取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



@end
