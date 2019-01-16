//
//  ItemTableViewController.m
//  WzryLibrary
//
//  Created by iOS123 on 2019/1/15.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "ItemTableViewController.h"
#import "ItemTableViewCell.h"
#import "ItemDetailViewController.h"

@interface ItemTableViewController ()
@property NSArray<NSDictionary *> *itemlist;
@end

@implementation ItemTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //从item读取数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"item" ofType:@"json"];
    NSString *json_herolist = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData_herolist = [json_herolist dataUsingEncoding:NSUTF8StringEncoding];
    self.itemlist = [NSJSONSerialization JSONObjectWithData:jsonData_herolist options:NSJSONReadingMutableLeaves error:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemlist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCell" forIndexPath:indexPath];
    // Configure the cell...
    cell.itemName.text = self.itemlist[indexPath.row][@"item_name"];
    cell.itemTotalPrice.text =[[NSString alloc] initWithFormat:@"价格： %@",self.itemlist[indexPath.row][@"total_price"]] ;
    
    //设置图标
    NSString *stringUrl = [[NSString alloc]initWithFormat:@"https://game.gtimg.cn/images/yxzj/img201606/itemimg/%@.jpg",self.itemlist[indexPath.row][@"item_id"]];
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
        image = [self scaleToSize:image size:(CGSize)CGSizeMake(80, 80)];
    }
    ItemTableViewCell *cell = dic[@"cell"];
    [cell.itemImage setImage:image];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showItem"]) {
        ItemDetailViewController *idvc = [segue destinationViewController];
        ItemTableViewCell *cell = [[ItemTableViewCell alloc]init];
        cell = [self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]];
        idvc.image = cell.itemImage.image;
        idvc.itemDetail = self.itemlist[self.tableView.indexPathForSelectedRow.row];
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
