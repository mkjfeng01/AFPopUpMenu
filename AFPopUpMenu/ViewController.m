//
//  ViewController.m
//  AFPopUpMenu
//
//  Created by zhangfeng on 2017/7/11.
//  Copyright © 2017年 zhangfeng. All rights reserved.
//

#import "ViewController.h"
#import "AFPopUpMenu.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

// FIXME:数组初始化优化

- (IBAction)showButtonPressed:(id)sender {
    
    ///=============================================================================
    
    // 构建标题类数组结构：最多只能包含两个数组！
    // @[ @[NSString, NSString..], @[NSString, NSString..] ]
    
    // 构建图片类数组结构：最多只能包含两个数组！(NSString可以是本地图片，也可以是网络图片URL地址)
    // @[ @[NSString, NSString..], @[NSString, NSString..] ]
    
    // 务必保证每个数组里边参数个数都相同！
    
    ///=============================================================================
    
    
    
    NSString *title = @"请选择你要进行的操作";
    NSArray *titleArray = @[
  @[@"联系人",@"转发", @"朋友圈", @"收藏", @"QQ控件", @"短信", @"分享到FaceBook", @"分享到Twitter", @"购物车", @"微信读书"],
  @[@"置顶", @"刷新", @"复制链接", @"调整字体"]
  ];
    
    NSArray *imageArray = @[
  @[@"Action_Verified", @"Action_Share", @"Action_Moments", @"Action_MyFavAdd", @"Action_qzone", @"Action_Email", @"Action_facebook",@"Action_Twitter", @"Action_JD_cart", @"Action_WeRead"],
  @[@"Action_BackToChatSession", @"Action_Refresh", @"Action_Copy", @"Action_Font"]
  ];
    
    [AFPopUpMenu showWithTitle:title
                     menuArray:titleArray
                    imageArray:imageArray
                     doneBlock:^(NSIndexPath *selectedIndexPath) {
                         NSLog(@"%zd - %zd", selectedIndexPath.section, selectedIndexPath.row);
                               } dismissBlock:^{
                                   NSLog(@"dismiss");
                               }];
}

@end
