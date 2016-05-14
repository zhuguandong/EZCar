//
//  ShopCSViewController.m
//  EZCar
//
//  Created by fang on 16/4/25.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import "ShopCSViewController.h"


@interface ShopCSViewController ()

@property (strong, nonatomic) PFObject *object;
@property NSArray *objiectForShow;
@property (nonatomic, strong)UIButton *rightBtn;//右按钮

@end

@implementation ShopCSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = _objectForCS[@"xinghao"];
    
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"111"]];
    imageView.image=[UIImage imageNamed:@"111"];
    [self.tableView setBackgroundView:imageView];

    //_tableView.allowsSelection = NO;//让tableview不被按
    //[_tableView setSeparatorColor:[UIColor grayColor]];  //设置分割线为蓝色
    
    _objiectForShow = @[@"品牌",@"厂商报价",@"上市年份",@"变速箱",@"车身结构",@"车型级别",@"排量",@"最大马力",@"油耗",@"燃料形式",@"驱动方式",@"进气形式",@"助力类型",@"前悬架类型",@"前轮胎规格",@"后轮胎规格",@"备胎规格",@"后悬架类型",@"主/副驾驶安全气囊",@"前/后排头部气囊(气帘)",@"前制动器类型",@"整车质保",@"ASB防抱死",@"方向盘调节",@"最大扭矩转速(rpm)",@"配气机构",@"行李厢容积(L)",@"长*宽*高(mm)",@"发动机",@"供油方式",@"座椅材质",@"环保标准",];
    
    //[self request];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    
    //[rightBarButton addTarget:self action:@selector(setviewinfo) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem setRightBarButtonItem:rightBarButton];

    
}

//rightBtn的懒加载
- (UIButton *)rightBtn
{
    if (_rightBtn == nil) {
        _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(180, 0, 30, 30)];
        //[_rightBtn setBackgroundImage:[UIImage imageNamed:@"buttonbar_action@2x"] forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_rightBtn setTitle:@"+" forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:30];
        [_rightBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

        [_rightBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}
-(void)addAction{
    PFUser *currentUser = [PFUser currentUser];
    NSLog(@"currentUser = %@", currentUser);
    if (currentUser) {
        PFObject *obj = [PFObject objectWithClassName:@"Vs"];
        PFUser *user = [PFUser currentUser];
        obj[@"user"] = user;
        obj[@"canshu"] = _objectForCS;
        
        
        UIActivityIndicatorView *avi =[Utilities getCoverOnView:self.view];
        self.navigationController.view.userInteractionEnabled = NO;
        
        [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            [avi stopAnimating];
            self.navigationController.view.userInteractionEnabled =YES;
            
            if (succeeded) {
                
                
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"添加对比成功！" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"朕知晓" style:UIAlertActionStyleCancel handler:nil];
                [alertView addAction:ok];
                
                [self presentViewController:alertView animated:YES completion:nil];
                
            }else {
                NSLog(@"Error: %@",error.description);
                [Utilities popUpAlertViewWithMsg:@"网络繁忙，稍后再试" andTitle:nil onView:self];
                
                
            }
            
        }];
        
    }else{
        
        NSLog(@"当前用户没登录");
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"当前未登录，是否前往登录？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ConfirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            UINavigationController *tabVC = [Utilities getStoryboardInstance:@"Main" byIdentity:@"sigin"];
            [self presentViewController:tabVC animated:YES completion:nil];
            
            
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alertView addAction:ConfirmAction];
        [alertView addAction:cancelAction];
        
        [self presentViewController:alertView animated:YES completion:nil];
        
        
    }
}




//tableView  多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objiectForShow.count;
}
//tableView 的显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier=@"cell";//创建一个静态字符串Cell表示需要复用的细胞名称
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIndentifier];//根据上述名称创建细胞（享元模型）
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    NSString *content=_objiectForShow[indexPath.row];//根据协议条款中indexPath参数可以获得表格中当前正在渲染的细胞的组与行的信息，根据其中的信息可以获得该行在_objiectForShow数组中所对应的文字
    cell.textLabel.text = content;
    
    
    switch (indexPath.row) {
        case 0:
            cell.detailTextLabel.text = _objectForCS[@"info"][@"info"][@"info"][@"carname"];;
            break;
        case 1:
            cell.detailTextLabel.text = _objectForCS[@"a2"];
            break;
        case 2:
            cell.detailTextLabel.text = _objectForCS[@"a3"];
            break;
        case 3:
            cell.detailTextLabel.text = _objectForCS[@"a4"];
            break;
        case 4:
            cell.detailTextLabel.text = _objectForCS[@"a5"];
            break;
        case 5:
            cell.detailTextLabel.text = _objectForCS[@"a6"];
            break;
        case 6:
            cell.detailTextLabel.text = _objectForCS[@"a7"];
            break;
        case 7:
            cell.detailTextLabel.text = _objectForCS[@"a8"];
            break;
        case 8:
            cell.detailTextLabel.text = _objectForCS[@"a9"];
            break;
        case 9:
            cell.detailTextLabel.text = _objectForCS[@"a10"];
            break;
        case 10:
            cell.detailTextLabel.text = _objectForCS[@"a11"];
            break;
        case 11:
            cell.detailTextLabel.text = _objectForCS[@"a12"];
            break;
        case 12:
            cell.detailTextLabel.text = _objectForCS[@"a13"];
            break;
        case 13:
            cell.detailTextLabel.text = _objectForCS[@"a14"];
            break;
        case 14:
            cell.detailTextLabel.text = _objectForCS[@"a15"];
            break;
        case 15:
            cell.detailTextLabel.text = _objectForCS[@"a16"];
            break;
        case 16:
            cell.detailTextLabel.text = _objectForCS[@"a17"];
            break;
        case 17:
            cell.detailTextLabel.text = _objectForCS[@"a18"];
            break;
        case 18:
            cell.detailTextLabel.text = _objectForCS[@"a19"];
            break;
        case 19:
            cell.detailTextLabel.text = _objectForCS[@"a20"];
            break;
        case 20:
            cell.detailTextLabel.text = _objectForCS[@"a21"];
            break;
        case 21:
            cell.detailTextLabel.text = _objectForCS[@"a22"];
            break;
        case 22:
            cell.detailTextLabel.text = _objectForCS[@"a23"];
            break;
        case 23:
            cell.detailTextLabel.text = _objectForCS[@"a24"];
            break;
        case 24:
            cell.detailTextLabel.text = _objectForCS[@"a25"];
            break;
        case 25:
            cell.detailTextLabel.text = _objectForCS[@"a26"];
            break;
        case 26:
            cell.detailTextLabel.text = _objectForCS[@"a27"];
            break;
        case 27:
            cell.detailTextLabel.text = _objectForCS[@"a28"];
            break;
        case 28:
            cell.detailTextLabel.text = _objectForCS[@"a29"];
            break;
        case 29:
            cell.detailTextLabel.text = _objectForCS[@"a30"];
            break;
        case 30:
            cell.detailTextLabel.text = _objectForCS[@"a31"];
            break;
        case 31:
            cell.detailTextLabel.text = _objectForCS[@"a32"];
            break;
        case 32:
            cell.detailTextLabel.text = _objectForCS[@"a33"];
            break;
            
            
        default:
            break;
    }
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
