// The MIT License (MIT)
//
// Copyright © 2017 mkjfeng01 <https://github.com/mkjfeng01>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AFPopUpMenuConfiguration : NSObject


@property (nonatomic, assign) CGFloat minimumLineSpacing; /*  */
@property (nonatomic, assign) CGFloat minimumInteritemSpacing; /*  */
@property (nonatomic, assign) CGFloat springWithDamping; /* 弹性动画弹性系数 */
@property (nonatomic, assign) CGFloat springVelocity; /* 弹性动画初始速度 */

@property (nonatomic, strong) UIFont *menuTitleFont; /* 菜单标题字体，默认系统字体12号 */
@property (nonatomic, strong) UIFont *exitTextFont; /* 底部按钮字体大小，默认系统字体15号 */
@property (nonatomic, strong) UIFont *itemTextFont; /* 分组标题字体，默认系统字体11号 */

@property (nonatomic, strong) UIColor *menuBackgroundColor; /* 背景颜色 */
@property (nonatomic, strong) UIColor *menuTitleColor; /* 菜单标题字体颜色，默认深灰色(darkGray) */
@property (nonatomic, strong) UIColor *backgroundColor; /* 菜单整体背景色 */
@property (nonatomic, strong) UIColor *exitTextColor; /* 底部退出按钮标题颜色，默认深灰色 */
@property (nonatomic, strong) UIColor *itemTextColor; /* 分组标题字体颜色，默认深灰色(darkGray) */
@property (nonatomic, strong) UIColor *separatorColor; /* 如果显示分割线，分割线颜色 */

@property (nonatomic, copy) NSString *exitText; /* 底部退出按钮标题，默认`取消` */

@property (nonatomic, assign) BOOL blurEffectAvailable;
@property (nonatomic, assign) BOOL showSeparator; /* 是否显示上下分组之间的分割线 */
@property (nonatomic, assign) BOOL showScrollIndicator; /* 上下分组是否显示每个分组底部的滚动条 */
@property (nonatomic, assign) BOOL usingSpringAnimation; /* 菜单弹出时时是否使用弹簧动画 */

@property (nonatomic, assign) NSTimeInterval animationDuration; /* 菜单出现/消失动画执行时间 */
@property (nonatomic, assign) NSTextAlignment menuTitleAlignment; /* 菜单标题文字对齐方式，默认居中对齐 */

+ (AFPopUpMenuConfiguration *)defaultConfiguration;

@end


typedef void (^AFPopUpMenuDoneBlock) (NSIndexPath *selectedIndexPath);
typedef void (^AFPopUpMenuDismissBlock) (void);
typedef void (^AFPopUpMenuHitBlock) (NSString * _Nullable title);

@interface AFPopUpMenu : NSObject


/**
 Show menu without title, menuArray and imageArray

 @param menuArray menuArray
 @param imageArray imageArray
 @param doneBlock doneBlock
 @param dismissBlock dismissBlock
 */
+ (void)showWithMenuArray:(NSArray *)menuArray
               imageArray:(NSArray *)imageArray
                doneBlock:(AFPopUpMenuDoneBlock)doneBlock
             dismissBlock:(nullable AFPopUpMenuDismissBlock)dismissBlock;


/**
 Show menu with title, menuArray and imageArray

 @param title title
 @param menuArray menuArray
 @param imageArray imageArray
 @param doneBlock doneBlock
 @param dismissBlock dismissBlock
 */
+ (void)showWithTitle:(nullable NSString *)title
            menuArray:(NSArray *)menuArray
           imageArray:(NSArray *)imageArray
            doneBlock:(AFPopUpMenuDoneBlock)doneBlock
         dismissBlock:(nullable AFPopUpMenuDismissBlock)dismissBlock;

@end

NS_ASSUME_NONNULL_END
































