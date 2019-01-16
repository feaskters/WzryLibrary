//
//  ItemTableViewCell.h
//  WzryLibrary
//
//  Created by iOS123 on 2019/1/15.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ItemTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *itemImage;
@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UILabel *itemTotalPrice;

@end

NS_ASSUME_NONNULL_END
