//
//  HeroDetailViewController.m
//  WzryLibrary
//
//  Created by iOS123 on 2019/1/15.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "HeroDetailViewController.h"
#import "HeroOfficialInfoViewController.h"
#import <Photos/PHAssetChangeRequest.h>
#import "SVProgressHUD.h"

@interface HeroDetailViewController ()

@end

@implementation HeroDetailViewController

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
    self.name.text = self.heroDetail[@"cname"];
    self.prename.text = self.heroDetail[@"title"];
    self.title =self.heroDetail[@"cname"];
    self.firstlabel.text =[self getHeroType:self.heroDetail[@"hero_type"] ];
    self.secondlabel.text =[self getHeroType:self.heroDetail[@"hero_type2"]];
    self.allskin.text = self.heroDetail[@"skin_name"];
    //开线程获取图片
    NSString *ename = [[NSString alloc]initWithString:self.heroDetail[@"ename"]];
    //1.图片url
    //1.1 url_sm
    NSString *stringUrl_sm = [[NSString alloc]initWithFormat:@"https://game.gtimg.cn/images/yxzj/img201606/heroimg/%@/%@.jpg",ename,ename];
    NSURL *url_sm = [NSURL URLWithString:stringUrl_sm];
    NSDictionary *dic_sm = [[NSDictionary alloc]initWithObjectsAndKeys:url_sm,@"url", @"YES" ,@"is_sm", nil];
    //1.2 url_bg
    NSString *stringUrl_bg = [[NSString alloc]initWithFormat:@"https://game.gtimg.cn/images/yxzj/img201606/skin/hero-info/%@/%@-bigskin-1.jpg",ename,ename];
    NSURL *url_bg = [NSURL URLWithString:stringUrl_bg];
    NSDictionary *dic_bg = [[NSDictionary alloc]initWithObjectsAndKeys:url_bg,@"url",@"NO",@"is_sm", nil];
    //使用线程运行
    NSThread *thread_sm = [[NSThread alloc]initWithTarget:self selector:@selector(setImage:) object:dic_sm];
    NSThread *thread_bg = [[NSThread alloc]initWithTarget:self selector:@selector(setImage:) object:dic_bg];
    [thread_sm start];
    [thread_bg start];
    //设置长按保存u图片
    bgImageView.userInteractionEnabled = true;
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longpress:)];
    [bgImageView addGestureRecognizer:gesture];
    //跳出提示框
    UILabel *message = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/3, self.view.frame.size.width, 20)];
    message.text = @"长按可以保存图片哦!";
    message.textAlignment = NSTextAlignmentCenter;
    message.backgroundColor = [UIColor blackColor];
    message.textColor = [UIColor grayColor];
    [self.view addSubview:message];
    [self performSelector:@selector(vanishMessage:) withObject:message afterDelay:2];
}

-(void)vanishMessage:(UILabel *)label{
    [label removeFromSuperview];
}

-(void)longpress:(UILongPressGestureRecognizer *)longPress{
    if (longPress.delaysTouchesEnded) {
        //显示弹出框列表选择
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"保存图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction* saveAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            //[PHAssetChangeRequest creationRequestForAssetFromImage:self.bgImage.image];
            
            //--------------------------
            //(1) 获取当前的授权状态
            PHAuthorizationStatus lastStatus = [PHPhotoLibrary authorizationStatus];
            
            //(2) 请求授权
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                //回到主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if(status == PHAuthorizationStatusDenied) //用户拒绝（可能是之前拒绝的，有可能是刚才在系统弹框中选择的拒绝）
                    {
                        if (lastStatus == PHAuthorizationStatusNotDetermined) {
                            //说明，用户之前没有做决定，在弹出授权框中，选择了拒绝
                            [SVProgressHUD showErrorWithStatus:@"保存失败"];
                             [SVProgressHUD dismissWithDelay:0.5];
                            return;
                        }
                        // 说明，之前用户选择拒绝过，现在又点击保存按钮，说明想要使用该功能，需要提示用户打开授权
                        [SVProgressHUD showInfoWithStatus:@"失败！请在系统设置中开启访问相册权限"];
                         [SVProgressHUD dismissWithDelay:0.5];
                        
                    }
                    else if(status == PHAuthorizationStatusAuthorized) //用户允许
                    {
                        //保存图片---调用上面封装的方法
                        //1 把图片保存到系统相册中，结束后调用 image:didFinishSavingWithError:contextInfo:方法（回调方法）
                        //2 回调方法的格式有要求，可以进入头文件查看
                        UIImageWriteToSavedPhotosAlbum(self.bgImage.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
                        [SVProgressHUD showWithStatus:@"保存成功"];
                        [SVProgressHUD dismissWithDelay:0.5];
                       
                    }
                    else if (status == PHAuthorizationStatusRestricted)
                    {
                        [SVProgressHUD showErrorWithStatus:@"系统原因，无法访问相册"];
                         [SVProgressHUD dismissWithDelay:0.5];
                    }
                });
            }];
            
        }];
        [alert addAction:saveAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }

}

-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(error)
    {
        NSLog(@"保存图片失败");
        return;
    }
    NSLog(@"保存图片成功");
}


//保存图片
-(void)saveImage:(UIAlertAction *)action{
    
}

-(void)setImage:(NSDictionary *)dic{
    NSData *imageData = [[NSData alloc]init];
    imageData = [NSData dataWithContentsOfURL:dic[@"url"] options:NSDataReadingMappedIfSafe error:nil];
    UIImage *image = [UIImage imageWithData:imageData];
    //判断是小图还是大图
    if ([dic[@"is_sm"] isEqualToString:@"YES"]) {
        //判断图片大小
        if (image.size.height!=100||image.size.width!=100) {
            image = [self scaleToSize:image size:(CGSize)CGSizeMake(100, 100)];
        }
        [self.smImage setImage:image];
    }else if ([dic[@"is_sm"] isEqualToString:@"NO"]){
        //判断图片大小
        if (image.size.height!=201||image.size.width!=375) {
            image = [self scaleToSize:image size:(CGSize)CGSizeMake(375, 201)];
        }
        [self.bgImage setImage:image];
    }
   
}

/**
 *  改变图片的大小
 *
 *  @param img     需要改变的图片
 *  @param newsize 新图片的大小
 *
 *  @return 返回修改后的新图片
 */
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)newsize{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(newsize);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

//获取英雄定位
-(NSString *)getHeroType:(NSString*)type{
    switch ([type intValue]) {
        case 1:
            return @"战士";
            break;
        case 2:
            return @"法师";
            break;
        case 3:
            return @"坦克";
            break;
        case 4:
            return @"刺客";
            break;
        case 5:
            return @"射手";
            break;
        case 6:
            return @"辅助";
            break;
        default:
            return @"无";
            break;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showHeroOfficialInfo"] ) {
        HeroOfficialInfoViewController *hoivc = [segue destinationViewController];
        NSString *ename = [[NSString alloc]initWithString:self.heroDetail[@"ename"]];
        hoivc.url = [[NSURL alloc]initWithString:[[NSString alloc] initWithFormat:@"https://pvp.qq.com/web201605/herodetail/%@.shtml",ename] ];
    }
}

@end
