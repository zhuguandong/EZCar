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


@end

@implementation PKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableview.allowsSelection = NO;//让tableview不被按
    _objiectForShow = @[@"品牌",@"厂商报价",@"上市年份",@"变速箱",@"车身结构",@"车型级别",@"排量",@"最大马力",@"油耗",@"燃料形式",@"驱动方式",@"进气形式",@"助力类型",@"前悬架类型",@"前轮胎规格",@"后轮胎规格",@"备胎规格",@"后悬架类型",@"主/副驾驶安全气囊",@"前/后排头部气囊(气帘)",@"前制动器类型",@"整车质保",@"ASB防抱死",@"方向盘调节",@"最大扭矩转速(rpm)",@"配气机构",@"行李厢容积(L)",@"长*宽*高(mm)",@"发动机",@"供油方式",@"座椅材质",@"环保标准",];
   
    
   
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
    
//    switch (indexPath.row) {
//        case 0:
//            cell.car1CS.text = _object[@"canshu"][@"info"][@"info"][@"carname"];;
//            break;
//        case 1:
//            cell.car1CS.text = _object[@"a2"];
//            break;
//        case 2:
//            cell.car1CS.text = _object[@"a3"];
//            break;
//        case 3:
//            cell.detailTextLabel.text = _object[@"a4"];
//            break;
//        case 4:
//            cell.detailTextLabel.text = _object[@"a5"];
//            break;
//        case 5:
//            cell.detailTextLabel.text = _object[@"a6"];
//            break;
//        case 6:
//            cell.detailTextLabel.text = _object[@"a7"];
//            break;
//        case 7:
//            cell.detailTextLabel.text = _object[@"a8"];
//            break;
//        case 8:
//            cell.detailTextLabel.text = _object[@"a9"];
//            break;
//        case 9:
//            cell.detailTextLabel.text = _object[@"a10"];
//            break;
//        case 10:
//            cell.detailTextLabel.text = _object[@"a11"];
//            break;
//        case 11:
//            cell.detailTextLabel.text = _object[@"a12"];
//            break;
//        case 12:
//            cell.detailTextLabel.text = _object[@"a13"];
//            break;
//        case 13:
//            cell.detailTextLabel.text = _object[@"a14"];
//            break;
//        case 14:
//            cell.detailTextLabel.text = _object[@"a15"];
//            break;
//        case 15:
//            cell.detailTextLabel.text = _object[@"a16"];
//            break;
//        case 16:
//            cell.detailTextLabel.text = _object[@"a17"];
//            break;
//        case 17:
//            cell.detailTextLabel.text = _object[@"a18"];
//            break;
//        case 18:
//            cell.detailTextLabel.text = _object[@"a19"];
//            break;
//        case 19:
//            cell.detailTextLabel.text = _object[@"a20"];
//            break;
//        case 20:
//            cell.detailTextLabel.text = _object[@"a21"];
//            break;
//        case 21:
//            cell.detailTextLabel.text = _object[@"a22"];
//            break;
//        case 22:
//            cell.detailTextLabel.text = _object[@"a23"];
//            break;
//        case 23:
//            cell.detailTextLabel.text = _object[@"a24"];
//            break;
//        case 24:
//            cell.detailTextLabel.text = _object[@"a25"];
//            break;
//        case 25:
//            cell.detailTextLabel.text = _object[@"a26"];
//            break;
//        case 26:
//            cell.detailTextLabel.text = _object[@"a27"];
//            break;
//        case 27:
//            cell.detailTextLabel.text = _object[@"a28"];
//            break;
//        case 28:
//            cell.detailTextLabel.text = _object[@"a29"];
//            break;
//        case 29:
//            cell.detailTextLabel.text = _object[@"a30"];
//            break;
//        case 30:
//            cell.detailTextLabel.text = _object[@"a31"];
//            break;
//        case 31:
//            cell.detailTextLabel.text = _object[@"a32"];
//            break;
//        case 32:
//            cell.detailTextLabel.text = _object[@"a33"];
//            break;
//            
//            
//        default:
//            break;
//    }
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}
    
 


@end
