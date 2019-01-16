//
//  MingTableViewController.m
//  WzryLibrary
//
//  Created by iOS123 on 2019/1/15.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "MingTableViewController.h"
#import "MingTableViewCell.h"
@interface MingTableViewController ()
@property NSArray *mingList;
@end

@implementation MingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //从ming读取数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ming" ofType:@"json"];
    NSString *json_herolist = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData_herolist = [json_herolist dataUsingEncoding:NSUTF8StringEncoding];
    self.mingList = [NSJSONSerialization JSONObjectWithData:jsonData_herolist options:NSJSONReadingMutableLeaves error:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mingList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mingCell" forIndexPath:indexPath];
    cell.mingName.text =[[NSString alloc]initWithFormat:@"%@",self.mingList[indexPath.row][@"ming_name"] ] ;
   
    NSString *des = [[NSString alloc]initWithString:self.mingList[indexPath.row][@"ming_des"]];
    des = [des stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    des = [des stringByReplacingOccurrencesOfString:@"</p>" withString:@"\t"];
    cell.mingDetail.text = des;
    //加载图片
    NSURL *url = [[NSURL alloc]initWithString:[[NSString alloc]initWithFormat:@"https://game.gtimg.cn/images/yxzj/img201606/mingwen/%@.png",self.mingList[indexPath.row][@"ming_id"]]];
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:url,@"url",cell,@"cell", nil];
    //创建线程
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(setImage:) object:dic];
    [thread start];
    return cell;
}

-(void)setImage:(NSDictionary *)dic{
    NSData *imageData = [[NSData alloc]init];
    imageData = [NSData dataWithContentsOfURL:dic[@"url"] options:NSDataReadingMappedIfSafe error:nil];
    UIImage *image = [UIImage imageWithData:imageData];
    MingTableViewCell *cell = dic[@"cell"];
    [cell.imageView setImage:image];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
