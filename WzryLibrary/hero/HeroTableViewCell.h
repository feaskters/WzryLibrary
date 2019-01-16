//
//  HeroTableViewCell.h
//  WzryLibrary
//
//  Created by iOS123 on 2019/1/14.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeroTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *heroImageView;
@property (weak, nonatomic) IBOutlet UILabel *heroPrename;
@property (weak, nonatomic) IBOutlet UILabel *heroName;

@end

NS_ASSUME_NONNULL_END
