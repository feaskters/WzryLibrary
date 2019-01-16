//
//  HeroOfficialInfoViewController.m
//  WzryLibrary
//
//  Created by iOS123 on 2019/1/15.
//  Copyright © 2019年 iOS123. All rights reserved.
//

#import "HeroOfficialInfoViewController.h"
#import <WebKit/WebKit.h>
@interface HeroOfficialInfoViewController ()

@end

@implementation HeroOfficialInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURLRequest *urlRequest = [[NSURLRequest alloc]initWithURL:self.url];
    WKWebView *wkview = [[WKWebView alloc]initWithFrame:self.view.bounds];
    [wkview loadRequest:urlRequest];
    [self.view addSubview:wkview];
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
