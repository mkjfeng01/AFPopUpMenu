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

@property (nonatomic, copy) NSString *menuTitle;

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, strong) NSArray *singleTitleArray;
@property (nonatomic, strong) NSArray *singleImageArray;
@property (nonatomic, strong) NSArray *doubleTitleArray;
@property (nonatomic, strong) NSArray *doubleImageArray;

@end

///=============================================================================

// 构建标题类数组结构：最多只能包含两个数组！
// @[ @[NSString, NSString..], @[NSString, NSString..] ]

// 构建图片类数组结构：最多只能包含两个数组！(NSString可以是本地图片，也可以是网络图片URL地址)
// @[ @[NSString, NSString..], @[NSString, NSString..] ]

// 务必保证每个数组里边参数个数都相同！

///=============================================================================

@implementation AFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _menuTitle = @"请选择你要进行的操作";
    
    _singleTitleArray = @[
                          @[@"联系人",@"转发", @"朋友圈", @"收藏", @"QQ空间", @"短信", @"分享到FaceBook", @"分享到Twitter", @"购物车", @"微信读书"]
                        ];
    _singleImageArray = @[
                          @[@"Action_Verified", @"Action_Share", @"Action_Moments", @"Action_MyFavAdd", @"Action_qzone", @"Action_Email", @"Action_facebook",@"Action_Twitter", @"Action_JD_cart", @"Action_WeRead"]
                        ];
    
    _doubleTitleArray = @[
                          @[@"联系人",@"转发", @"朋友圈", @"收藏", @"QQ控件", @"短信", @"分享到FaceBook", @"分享到Twitter", @"购物车", @"微信读书"],
                          @[@"置顶", @"刷新", @"复制链接", @"调整字体"]
                        ];
    _doubleImageArray = @[
                          @[@"Action_Verified", @"Action_Share", @"Action_Moments", @"Action_MyFavAdd", @"Action_qzone", @"Action_Email", @"Action_facebook",@"Action_Twitter", @"Action_JD_cart", @"Action_WeRead"],
                          @[@"Action_BackToChatSession", @"Action_Refresh", @"Action_Copy", @"Action_Font"]
                        ];
    
    _titleArray = _singleTitleArray;
    _imageArray = _singleImageArray;
}

#pragma mark - AFPopUpMenu Initial

- (IBAction)alertPopUpMentView:(id)sender {
    [AFPopUpMenu showWithTitle:_menuTitle
                     menuArray:_titleArray
                    imageArray:_imageArray
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

#pragma mark - Actions

- (IBAction)showTitleSegmentControlValueChangedAction:(UISwitch *)sender {
    if (sender.on) {
        _menuTitle = @"请选择你要进行的操作";
    } else {
        _menuTitle = nil;
    }
}

- (IBAction)titleAlignmentSegmentControlValueChangedAction:(UISegmentedControl *)sender {
    [AFPopUpMenuConfiguration defaultConfiguration].menuTitleAlignment = sender.selectedSegmentIndex;
}

- (IBAction)sectionNumberSegmentControlValueChangedAction:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            _titleArray = _singleTitleArray;
            _imageArray = _singleImageArray;
            break;
        case 1:
            _titleArray = _doubleTitleArray;
            _imageArray = _doubleImageArray;
            break;
    }
}

- (IBAction)animationValueChangedAction:(UISwitch *)sender {
    [AFPopUpMenuConfiguration defaultConfiguration].usingSpringAnimation = sender.on;
}

@end
