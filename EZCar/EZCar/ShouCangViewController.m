//
//  ShouCangViewController.m
//  EZCar
//
//  Created by 欧阳 on 16/5/6.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import "ShouCangViewController.h"
#import "PrefixHeader.pch"
#import "PKViewController.h"

@interface ShouCangViewController ()

@property(strong,nonatomic) NSMutableArray *ShouCangForShow;
@property(strong, nonatomic)NSMutableArray *chooseForShow;

@end

@implementation ShouCangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    _ShouCangForShow = [NSMutableArray new];
    _chooseForShow = [NSMutableArray new];
    
    _tableView.tableFooterView = [[UITableView alloc]init];
    _tableView.allowsMultipleSelectionDuringEditing=YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestData {
    [_ShouCangForShow removeAllObjects];
    PFUser *currentUser = [PFUser currentUser];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"user = %@", currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Vs" predicate:predicate];
    [query includeKey:@"canshu"];
    self.navigationController.view.userInteractionEnabled = NO;
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        self.navigationController.view.userInteractionEnabled = YES;
        [avi stopAnimating];
        if (!error) {
            NSLog(@"objects = %@",objects);
            if (objects.count == 0 ) {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"您当前没有任何收藏哦～" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ConfirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                }];
               
                
                [alertView addAction:ConfirmAction];
                
                
                [self presentViewController:alertView animated:YES completion:nil];
                
                
            }else {
                _ShouCangForShow = [NSMutableArray arrayWithArray:objects];
                [_tableView reloadData];
            }
                
            
            
        
            
        }else {
            NSLog(@"Error: %@",error.userInfo);
            [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
        }
        
    }];
    
}








- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _ShouCangForShow.count;
}
//tableView 的显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier=@"Cell";//创建一个静态字符串Cell表示需要复用的细胞名称
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    PFObject *obj = _ShouCangForShow[indexPath.row];
    cell.textLabel.text = obj[@"canshu"][@"xinghao"];
    
        
    return cell;
}

////当tableview中任意某一行被触摸时调用以下方法
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//
//{
//    
//
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];//当选中某一行后，立即将是否选中状态恢复为未选中
//    
//}

- (IBAction)backAction:(UIBarButtonItem *)sender {
    [ self dismissViewControllerAnimated: YES completion: nil ];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    //实现编辑状态多选
    if (self.tableView.editing) {
        return UITableViewCellEditingStyleInsert|UITableViewCellEditingStyleDelete;
    }
    //普通状态左滑删除
    else{
        return UITableViewCellEditingStyleDelete;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;//返回是否同意tabliview中的行被移动数据
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"删除";
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //[_ShouCangForShow removeObjectAtIndex:indexPath.row]; //本地数组删除
        
        //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade]; //本地行数删除
        
        
        [_ShouCangForShow[indexPath.row] deleteInBackground];
        [_ShouCangForShow removeObjectAtIndex:indexPath.row]; //本地数组删除
        //[self requestData];
        [tableView reloadData];

        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}

- (IBAction)chooseAction:(UIButton *)sender forEvent:(UIEvent *)event {
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    NSString *tag = self.tableView.editing ? @"取消":@"选择对比";
    
    [_chooce setTitle:tag forState:UIControlStateNormal];
}




- (IBAction)goVSAction:(UIButton *)sender forEvent:(UIEvent *)event {
    NSArray *arr = self.tableView.indexPathsForSelectedRows;
    for (NSIndexPath *indexPath in arr) {
        
        [_chooseForShow addObject:_ShouCangForShow[indexPath.row]];
    }
    NSLog(@"%@",_chooseForShow);
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    NSIndexPath *indexPath = _tableView.indexPathForSelectedRow;
//    PKViewController *vc = [[PKViewController alloc]init];
    }
@end
