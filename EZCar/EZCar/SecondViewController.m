//
//  SecondViewController.m
//  EZCar
//
//  Created by 欧阳 on 16/4/18.
//  Copyright © 2016年 EZone. All rights reserved.
//

#import "SecondViewController.h"
#import "SecondTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "XingHaoViewController.h"
#import "ChineseToPinyin.h"

@interface SecondViewController ()

@property(strong,nonatomic) NSMutableArray *carNameForShow;
@property(strong,nonatomic) NSMutableArray *sectionTitles;


@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _carNameForShow = [NSMutableArray new];
    _sectionTitles = [NSMutableArray new];
    [self requestData];
    _tableView.tableFooterView = [[UITableView alloc]init];
    // Do any additional setup after loading the view.
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dd"]];
    imageView.image=[UIImage imageNamed:@"444"];
    [self.tableView setBackgroundView:imageView];
    //[imageView release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//拿数据
- (void)requestData {
    [_carNameForShow removeAllObjects];
    
    PFQuery *query = [PFQuery queryWithClassName:@"PinPai"];
    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"carname" ascending:YES selector:@selector(localizedCompare:)];
    [query orderBySortDescriptor:sortDesc];
    //[query orderByAscending:@"carname"];
   
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
            NSLog(@"排序前＝ %@",objects);
            _carNameForShow = [self sortDataArray:objects];
            
            NSLog(@"排序后 = %@",_carNameForShow);
            NSLog(@"_sectionTitles = %@", _sectionTitles);
            [_tableView reloadData];
        }else{
            NSLog(@"Error: %@",error.userInfo);
            [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
        }
    }];
    
    
    
    
    
}
//
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    NSMutableArray *sectionIndex = [NSMutableArray new];
//    for (int i = 0; i < _carNameForShow.count; i ++) {
//        NSArray *arr = _carNameForShow[i];
//        if (arr.count > 0) {
//            [sectionIndex addObject:_sectionTitles[i]];
//        }
//    }
//    return sectionIndex;
//}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *arr = _carNameForShow[section];
    if (arr.count > 0) {
        return _sectionTitles[section];
    } else {
        return nil;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _carNameForShow.count;
}

//tableView  多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = _carNameForShow[section];
    return arr.count;
}
//tableView 的显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSArray *arr = _carNameForShow[indexPath.section];
    PFObject *obj = arr[indexPath.row];
    NSString *carname = obj[@"carname"];
    cell.carName.text = carname;
    PFFile *photoFile = obj[@"tubiao"];
    //获取数据库中某个文件的网络路径1
    NSString *photoURLStr = photoFile.url;
    NSURL *photoURL = [NSURL URLWithString:photoURLStr];
    //结合SDWebImage通过图片路径来实现异步加载和缓存（本案中加载到一个图片视图上）
    [cell.logoImage sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"Image-7"]];
     cell.backgroundColor=[UIColor clearColor];
    cell.carName.textColor = [UIColor whiteColor];
    
    
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
    NSArray *arr = _carNameForShow[indexPath.section];
    PFObject *obj = arr[indexPath.row];
    
    XingHaoViewController *cdVC = segue.destinationViewController;
    cdVC.objectForXH = obj;
}

- (NSMutableArray *)sortDataArray:(NSArray *)dataArray
{
    //建立索引的核心
    UILocalizedIndexedCollation *indexCollation = [UILocalizedIndexedCollation currentCollation];
    
    [self.sectionTitles removeAllObjects];
    [self.sectionTitles addObjectsFromArray:[indexCollation sectionTitles]];
    
    //返回27，是a－z和＃
    NSInteger highSection = [self.sectionTitles count];
    //tableView 会被分成27个section
    NSMutableArray *sortedArray = [NSMutableArray arrayWithCapacity:highSection];
    for (int i = 0; i <= highSection; i++) {
        NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
        [sortedArray addObject:sectionArray];
    }
    
    //名字分section
    for (PFObject *obj in dataArray) {
        //getUserName是实现中文拼音检索的核心，见NameIndex类
        NSString *firstLetter = [ChineseToPinyin pinyinFromChineseString:obj[@"carname"]];
        NSInteger section = [indexCollation sectionForObject:[firstLetter substringToIndex:1] collationStringSelector:@selector(uppercaseString)];
        
        NSMutableArray *array = [sortedArray objectAtIndex:section];
        [array addObject:obj];
    }
    
    //每个section内的数组排序
    for (int i = 0; i < [sortedArray count]; i++) {
        NSArray *array = [[sortedArray objectAtIndex:i] sortedArrayUsingComparator:^NSComparisonResult(PFObject *obj1, PFObject *obj2) {
            NSString *firstLetter1 = [ChineseToPinyin pinyinFromChineseString:obj1[@"carname"]];
            firstLetter1 = [[firstLetter1 substringToIndex:1] uppercaseString];
            
            NSString *firstLetter2 = [ChineseToPinyin pinyinFromChineseString:obj2[@"carname"]];
            firstLetter2 = [[firstLetter2 substringToIndex:1] uppercaseString];
            
            return [firstLetter1 caseInsensitiveCompare:firstLetter2];
        }];
        
        [sortedArray replaceObjectAtIndex:i withObject:[NSMutableArray arrayWithArray:array]];
    }
    
    return sortedArray;
}


@end
