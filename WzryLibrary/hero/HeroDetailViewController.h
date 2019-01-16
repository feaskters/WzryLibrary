//
//  HeroDetailViewController.h
//  WzryLibrary
//
//  Created by iOS123 on 2019/1/15.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeroDetailViewController : UIViewController
//所有控件
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UIImageView *smImage;
@property (weak, nonatomic) IBOutlet UILabel *prename;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *firstlabel;
@property (weak, nonatomic) IBOutlet UILabel *secondlabel;
@property (weak, nonatomic) IBOutlet UILabel *allskin;
//参数
@property NSDictionary *heroDetail;
@end

NS_ASSUME_NONNULL_END
