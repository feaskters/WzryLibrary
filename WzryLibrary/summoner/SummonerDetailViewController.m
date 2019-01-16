//
//  SummonerDetailViewController.m
//  WzryLibrary
//
//  Created by iOS123 on 2019/1/16.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "SummonerDetailViewController.h"

@interface SummonerDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation SummonerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view./
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
    //背景设置结束------------------------
    //大图
    UIImage *bgimage = [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:[[NSString alloc]initWithFormat:@"%@-big",self.summonerDetail[@"summoner_id"]] ofType:@"jpg"] ];
    [self.summonerImage setImage:bgimage];
    //小图
    UIImage *smimage = [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:[[NSString alloc]initWithFormat:@"%@",self.summonerDetail[@"summoner_id"]] ofType:@"jpg"] ];
    [self.summonerIcon setImage:smimage];
    //名字
    self.name.text =[[NSString alloc]initWithFormat:@"%@",self.summonerDetail[@"summoner_name"]] ;
    //等级
    self.level.text =[[NSString alloc]initWithFormat:@"%@",self.summonerDetail[@"summoner_rank"]] ;
    //详情
    self.detail.text =[[NSString alloc]initWithFormat:@"%@",self.summonerDetail[@"summoner_description"]] ;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
