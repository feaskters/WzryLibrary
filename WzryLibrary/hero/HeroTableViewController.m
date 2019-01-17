//
//  HeroTableViewController.m
//  WzryLibrary
//
//  Created by iOS123 on 2019/1/14.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "HeroTableViewController.h"
#import "HeroTableViewCell.h"
#import "HeroDetailViewController.h"
@interface HeroTableViewController ()
@property NSArray<NSDictionary *> *herolist;
@end

@implementation HeroTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //从herolist读取数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"herolist" ofType:@"json"];
    NSString *json_herolist = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData_herolist = [json_herolist dataUsingEncoding:NSUTF8StringEncoding];
    self.herolist = [NSJSONSerialization JSONObjectWithData:jsonData_herolist options:NSJSONReadingMutableLeaves error:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _herolist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HeroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"heroCell" forIndexPath:indexPath];
    //设置姓名和称号
    cell.heroName.text = _herolist[indexPath.row][@"cname"];
    cell.heroPrename.text = _herolist[indexPath.row][@"title"];
    //设置图标
    NSString *stringUrl = [[NSString alloc]initWithFormat:@"https://game.gtimg.cn/images/yxzj/img201606/heroimg/%@/%@.jpg",_herolist[indexPath.row][@"ename"],_herolist[indexPath.row][@"ename"]];
    NSURL *url = [NSURL URLWithString:stringUrl];
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:cell,@"cell",url,@"url", nil];
    //开线程
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(setImage:) object:dic];
    [thread start];
    
    return cell;
}

-(void)setImage:(NSDictionary *)dic{
    NSData *imageData = [[NSData alloc]init];
    imageData = [NSData dataWithContentsOfURL:dic[@"url"] options:NSDataReadingMappedIfSafe error:nil];
    UIImage *image = [UIImage imageWithData:imageData];
    //判断图片大小
    if (image.size.height!=100||image.size.width!=100) {
        image = [self scaleToSize:image size:(CGSize)CGSizeMake(100, 100)];
    }
    HeroTableViewCell *cell = dic[@"cell"];
    [cell.heroImageView setImage:image];
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

//页面跳转
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    if([segue.identifier isEqualToString:@"showHeroDetail"]){
        HeroDetailViewController *detailView = [segue destinationViewController];
        detailView.heroDetail = self.herolist[self.tableView.indexPathForSelectedRow.row];
    }
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



@end
