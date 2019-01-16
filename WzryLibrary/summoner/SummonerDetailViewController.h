//
//  SummonerDetailViewController.h
//  WzryLibrary
//
//  Created by iOS123 on 2019/1/16.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SummonerDetailViewController : UIViewController
@property NSDictionary * summonerDetail;
@property (weak, nonatomic) IBOutlet UIImageView *summonerImage;
@property (weak, nonatomic) IBOutlet UIImageView *summonerIcon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *level;
@property (weak, nonatomic) IBOutlet UITextView *detail;

@end

NS_ASSUME_NONNULL_END
