//
//  AFViewController.m
//  AFPopUpMenu
//
//  Created by mkjfeng01 on 07/16/2017.
//  Copyright (c) 2017 mkjfeng01. All rights reserved.
//

#import "AFViewController.h"
#import <AFPopUpMenu/AFPopUpMenu.h>

@interface AFViewController ()

@end

@implementation AFViewController

///=============================================================================

// 构建标题类数组结构：最多只能包含两个数组！
// @[ @[NSString, NSString..], @[NSString, NSString..] ]

// 构建图片类数组结构：最多只能包含两个数组！(NSString可以是本地图片，也可以是网络图片URL地址)
// @[ @[NSString, NSString..], @[NSString, NSString..] ]

// 务必保证每个数组里边参数个数都相同！

///=============================================================================

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(.3 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       [tableView deselectRowAtIndexPath:indexPath animated:YES];
                   });
    
    NSString *title = @"请选择你要进行的操作";
    NSArray *singleTitleArray = @[
                                  @[@"联系人",@"转发", @"朋友圈", @"收藏", @"QQ空间", @"短信", @"分享到FaceBook", @"分享到Twitter", @"购物车", @"微信读书"]
                                  ];
    NSArray *singleImageArray = @[
                                  @[@"Action_Verified", @"Action_Share", @"Action_Moments", @"Action_MyFavAdd", @"Action_qzone", @"Action_Email", @"Action_facebook",@"Action_Twitter", @"Action_JD_cart", @"Action_WeRead"]
                                  ];
    
    NSArray *doubleTitleArray = @[
                                  @[@"联系人",@"转发", @"朋友圈", @"收藏", @"QQ控件", @"短信", @"分享到FaceBook", @"分享到Twitter", @"购物车", @"微信读书"],
                                  @[@"置顶", @"刷新", @"复制链接", @"调整字体"]
                                  ];
    NSArray *doubleImageArray = @[
                                  @[@"Action_Verified", @"Action_Share", @"Action_Moments", @"Action_MyFavAdd", @"Action_qzone", @"Action_Email", @"Action_facebook",@"Action_Twitter", @"Action_JD_cart", @"Action_WeRead"],
                                  @[@"Action_BackToChatSession", @"Action_Refresh", @"Action_Copy", @"Action_Font"]
                                  ];
    
    NSArray *titleArray = doubleTitleArray;
    NSArray *imageArray = doubleImageArray;
    
    if (indexPath.section == 0) {
        [AFPopUpMenuConfiguration defaultConfiguration].usingSpringAnimation = NO;
        
        if (indexPath.row == 0) {
            
        } else if (indexPath.row == 1) {
            title = nil;
        } else if (indexPath.row == 2) {
            titleArray = singleTitleArray;
            imageArray = singleImageArray;
        }
    } else {
        [AFPopUpMenuConfiguration defaultConfiguration].usingSpringAnimation = YES;
        
        if (indexPath.row == 0) {
        } else if (indexPath.row == 1) {
            title = nil;
        } else if (indexPath.row == 2) {
            titleArray = singleTitleArray;
            imageArray = singleImageArray;
        }
    }
    
    
    
    [AFPopUpMenu showWithTitle:title
                     menuArray:titleArray
                    imageArray:imageArray
                     doneBlock:^(NSIndexPath * _Nonnull selectedIndexPath) {
                         // do something..
                     }
                  dismissBlock:^{
                      // do something..
                  }];
    
    [AFPopUpMenu showWithTitle:title
                     menuArray:titleArray
                    imageArray:imageArray
                     doneBlock:^(NSIndexPath *selectedIndexPath) {
                         NSString *describe = [NSString stringWithFormat:@"Did selected: %zd - %zd", selectedIndexPath.section, selectedIndexPath.row];
                         
                         UIAlertController *alert = [UIAlertController alertControllerWithTitle:describe message:nil preferredStyle:UIAlertControllerStyleAlert];
                         UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:NULL];
                         [alert addAction:confirmAction];
                         UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:NULL];
                         [alert addAction:cancelAction];
                         
                         [self presentViewController:alert animated:YES completion:NULL];
                     }
                  dismissBlock:^{
                      NSLog(@"dismiss");
                  }];
}


@end
