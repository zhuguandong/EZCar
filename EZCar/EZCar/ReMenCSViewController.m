//
//  ReMenCSViewController.m
//  EZCar
//
//  Created by 贺先生 on 16/4/23.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import "ReMenCSViewController.h"
#import "TabViewController.h"

@interface ReMenCSViewController ()
@property NSArray *objiect;

@end

@implementation ReMenCSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    _tableview.allowsSelection = NO;//让tableview不被按
    
        _name.text = _objectForRM[@"info"][@"kuanshi"];
        _tableview.allowsSelection = NO;//让tableview不被按
        //[_tableView setSeparatorColor:[UIColor grayColor]];  //设置分割线为蓝色
        
        _objiect = @[@"品牌",@"厂商报价",@"上市年份",@"变速箱",@"车身结构",@"车型级别",@"排量",@"最大马力",@"油耗",@"燃料形式",@"驱动方式",@"进气形式",@"助力类型",@"前悬架类型",@"前轮胎规格",@"后轮胎规格",@"备胎规格",@"后悬架类型",@"主/副驾驶安全气囊",@"前/后排头部气囊(气帘)",@"前制动器类型",@"整车质保",@"ASB防抱死",@"方向盘调节",@"最大扭矩转速(rpm)",@"配气机构",@"行李厢容积(L)",@"长*宽*高(mm)",@"发动机",@"供油方式",@"座椅材质",@"环保标准",];
        
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//tableView  多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objiect.count;
}
//tableView 的显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier=@"Cell";//创建一个静态字符串Cell表示需要复用的细胞名称
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIndentifier];//根据上述名称创建细胞（享元模型）
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    NSString *content=_objiect[indexPath.row];//根据协议条款中indexPath参数可以获得表格中当前正在渲染的细胞的组与行的信息，根据其中的信息可以获得该行在_objiectForShow数组中所对应的文字
    cell.textLabel.text = content;
    
    switch (indexPath.row) {
        case 0:
            cell.detailTextLabel.text = _objectForRM[@"info"][@"info"][@"info"][@"carname"];;
            break;
        case 1:
            cell.detailTextLabel.text = _objectForRM[@"a2"];
            break;
        case 2:
            cell.detailTextLabel.text = _objectForRM[@"a3"];
            break;
        case 3:
            cell.detailTextLabel.text = _objectForRM[@"a4"];
            break;
        case 4:
            cell.detailTextLabel.text = _objectForRM[@"a5"];
            break;
        case 5:
            cell.detailTextLabel.text = _objectForRM[@"a6"];
            break;
        case 6:
            cell.detailTextLabel.text = _objectForRM[@"a7"];
            break;
        case 7:
            cell.detailTextLabel.text = _objectForRM[@"a8"];
            break;
        case 8:
            cell.detailTextLabel.text = _objectForRM[@"a9"];
            break;
        case 9:
            cell.detailTextLabel.text = _objectForRM[@"a10"];
            break;
        case 10:
            cell.detailTextLabel.text = _objectForRM[@"a11"];
            break;
        case 11:
            cell.detailTextLabel.text = _objectForRM[@"a12"];
            break;
        case 12:
            cell.detailTextLabel.text = _objectForRM[@"a13"];
            break;
        case 13:
            cell.detailTextLabel.text = _objectForRM[@"a14"];
            break;
        case 14:
            cell.detailTextLabel.text = _objectForRM[@"a15"];
            break;
        case 15:
            cell.detailTextLabel.text = _objectForRM[@"a16"];
            break;
        case 16:
            cell.detailTextLabel.text = _objectForRM[@"a17"];
            break;
        case 17:
            cell.detailTextLabel.text = _objectForRM[@"a18"];
            break;
        case 18:
            cell.detailTextLabel.text = _objectForRM[@"a19"];
            break;
        case 19:
            cell.detailTextLabel.text = _objectForRM[@"a20"];
            break;
        case 20:
            cell.detailTextLabel.text = _objectForRM[@"a21"];
            break;
        case 21:
            cell.detailTextLabel.text = _objectForRM[@"a22"];
            break;
        case 22:
            cell.detailTextLabel.text = _objectForRM[@"a23"];
            break;
        case 23:
            cell.detailTextLabel.text = _objectForRM[@"a24"];
            break;
        case 24:
            cell.detailTextLabel.text = _objectForRM[@"a25"];
            break;
        case 25:
            cell.detailTextLabel.text = _objectForRM[@"a26"];
            break;
        case 26:
            cell.detailTextLabel.text = _objectForRM[@"a27"];
            break;
        case 27:
            cell.detailTextLabel.text = _objectForRM[@"a28"];
            break;
        case 28:
            cell.detailTextLabel.text = _objectForRM[@"a29"];
            break;
        case 29:
            cell.detailTextLabel.text = _objectForRM[@"a30"];
            break;
        case 30:
            cell.detailTextLabel.text = _objectForRM[@"a31"];
            break;
        case 31:
            cell.detailTextLabel.text = _objectForRM[@"a32"];
            break;
        case 32:
            cell.detailTextLabel.text = _objectForRM[@"a33"];
            break;
            
            
        default:
            break;
    }

   
    
    return cell;
}






- (IBAction)BackAction:(UIButton *)sender forEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
