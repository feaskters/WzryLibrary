//
//  MingTableViewCell.h
//  WzryLibrary
//
//  Created by iOS123 on 2019/1/15.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mingImage;
@property (weak, nonatomic) IBOutlet UILabel *mingName;
@property (weak, nonatomic) IBOutlet UILabel *mingDetail;

@end

NS_ASSUME_NONNULL_END
