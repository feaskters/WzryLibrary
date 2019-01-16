//
//  SummonerViewController.m
//  WzryLibrary
//
//  Created by iOS123 on 2019/1/16.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "SummonerViewController.h"
#import "SummonerCollectionViewCell.h"
#import "SummonerDetailViewController.h"
@interface SummonerViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property NSArray *summonerList;

@end

@implementation SummonerViewController
static NSString * const reuseIdentifier = @"summonerCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //背景设置开始************************
    //创建uiimageview
    UIImageView *bgImageView = [[UIImageView alloc]init];
    //设置尺寸
    bgImageView.frame = self.view.bounds;
    //设置背景
    bgImageView.image = [UIImage imageNamed:@"bg2"];
    //设置内容模式
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    //创建uitoolbar,添加毛玻璃
    UIToolbar *toolbar = [[UIToolbar alloc]init];
    toolbar.frame = bgImageView.bounds;
    toolbar.alpha = 0.98;
    [bgImageView addSubview:toolbar];
    [self.view addSubview:bgImageView];
    [self.view sendSubviewToBack:bgImageView];
    [self.collection setBackgroundColor:nil];
    //背景设置结束------------------------
    //注册cell
    [self.collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collection.dataSource = self;
    self.collection.delegate = self;
    
    //从summoner读取数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"summoner" ofType:@"json"];
    NSString *json_herolist = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData_herolist = [json_herolist dataUsingEncoding:NSUTF8StringEncoding];
    self.summonerList = [NSJSONSerialization JSONObjectWithData:jsonData_herolist options:NSJSONReadingMutableLeaves error:nil];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return  1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.summonerList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SummonerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"summonerCell" forIndexPath:indexPath];
       NSString *name =[[NSString alloc]initWithFormat:@"%@",self.summonerList[indexPath.row][@"summoner_name"]];
    NSString *path = [[NSBundle mainBundle]pathForResource:[[NSString alloc]initWithFormat:@"%@",self.summonerList[indexPath.row][@"summoner_id"]] ofType:@"jpg"];
    UIImage *image = [[UIImage alloc]initWithContentsOfFile:path];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.layer.borderColor = [UIColor blueColor].CGColor;
    imageView.layer.borderWidth = 2;
    imageView.frame = CGRectMake(20, 20, imageView.frame.size.width, imageView.frame.size.height);
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(0, 110, cell.frame.size.width, 20);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = name;
    [cell addSubview:imageView];
    [cell addSubview:label];
    //cell.summonerImage.image = image;
    //cell.summonerImage.layer.borderColor = [UIColor blueColor].CGColor;
   // cell.summonerImage.layer.borderWidth = 2;
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(120 , 140);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //SummonerDetailViewController *sdvc = [SummonerDetailViewController alloc];
   // sdvc.summonerDetail = self.summonerList[indexPath.row];
    //[self.navigationController pushViewController:sdvc animated:true];
    UIStoryboard * storyBoard = [UIStoryboard
                                 storyboardWithName:@"Main" bundle:nil];
    SummonerDetailViewController *vc= [storyBoard instantiateViewControllerWithIdentifier:@"summoner"]; ///////通过storyboard来实例
    vc.summonerDetail = self.summonerList[self.collection.indexPathsForSelectedItems[0].row];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showSummoner"]) {
        SummonerDetailViewController *sdvc = [segue destinationViewController];
        sdvc.summonerDetail = self.summonerList[self.collection.indexPathsForSelectedItems[0].row];
    }
}

@end
