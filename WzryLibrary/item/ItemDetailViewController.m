//
//  ItemDetailViewController.m
//  WzryLibrary
//
//  Created by iOS123 on 2019/1/15.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "ItemDetailViewController.h"
#import <WebKit/WKWebView.h>

@interface ItemDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *total_price;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UITextView *detail;

@end

@implementation ItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //背景设置开始************************
    //创建uiimageview
    UIImageView *bgImageView = [[UIImageView alloc]init];
    //设置尺寸
    bgImageView.frame = self.view.bounds;
    //设置背景
    bgImageView.image = [UIImage imageNamed:@"bg"];
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
    self.imageView.image = self.image;
    self.itemName.text = self.itemDetail[@"item_name"];
    self.total_price.text = [[NSString alloc]initWithFormat:@"价格：%@", self.itemDetail[@"total_price"]];
    self.price.text = [[NSString alloc]initWithFormat:@"售价：%@", self.itemDetail[@"price"]];
    self.type.text =
    [[NSString alloc]initWithFormat:@"类型：%@", [self judgeType:self.itemDetail[@"item_type"]]];
    self.title = self.itemDetail[@"item_name"];
    //对装备信息字符串进行操作
    NSString *des1 = self.itemDetail[@"des1"];
    NSString *des2 = self.itemDetail[@"des2"];
    des1 = [des1 stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    des1 = [des1 stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    des1 = [des1 stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    if (!des2) {
        des2 = @"";
    }
    des2 = [des2 stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    des2 = [des2 stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    des2 = [des2 stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    self.detail.text = [[NSString alloc]initWithFormat:@"%@\n\n%@",des1,des2];
   
}
//判断物品类型
-(NSString *)judgeType:(NSString *)type{
    switch ([type intValue]) {
        case 1:
            return @"攻击";
            break;
        case 2:
            return @"法术";
            break;
        case 3:
            return @"防御";
            break;
        case 4:
            return @"移动";
            break;
        case 5:
            return @"打野";
            break;
        case 7:
            return @"辅助";
            break;
        default:
            return @"";
            break;
    }
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
