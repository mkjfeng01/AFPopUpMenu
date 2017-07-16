//Copyright © 2017 <https://github.com/mkjfeng01>
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

@property (nonatomic, assign) CGFloat margin; /* 标题控件距离屏幕左右边距 */
@property (nonatomic, assign) CGFloat interval; /* 控件之间上下边距 */
@property (nonatomic, assign) NSTimeInterval animationDuration; /* 菜单出现/消失动画执行时间 */
@property (nonatomic, strong) UIFont *menuTitleFont; /* 菜单标题字体，默认系统字体12号 */
@property (nonatomic, strong) UIColor *menuTitleColor; /* 菜单标题字体颜色，默认深灰色(darkGray) */
@property (nonatomic, strong) UIColor *backgroundColor; /* 菜单整体背景色 */
@property (nonatomic, assign) NSTextAlignment menuTitleAlignment; /* 菜单标题文字对齐方式，默认居中对齐 */
@property (nonatomic, copy) NSString *exitText; /* 底部退出按钮标题，默认`取消` */
@property (nonatomic, strong) UIColor *exitTextColor; /* 底部退出按钮标题颜色，默认深灰色 */
@property (nonatomic, strong) UIFont *exitTextFont; /* 底部退出按钮字体大小，默认系统字体15号 */
@property (nonatomic, assign) BOOL showSeparator; /* 是否显示上下分组之间的分割线 */
@property (nonatomic, strong) UIColor *separatorColor; /* 如果显示分割线，分割线颜色 */
@property (nonatomic, assign) BOOL showScrollIndicator; /* 上下分组是否显示每个分组底部的滚动条 */
@property (nonatomic, assign) UIEdgeInsets contentInset; /*  */
@property (nonatomic, assign) CGSize itemSize; /* 分组cell的大小 */
@property (nonatomic, assign) CGFloat minimumLineSpacing; /*  */
@property (nonatomic, assign) CGFloat minimumInteritemSpacing; /*  */
@property (nonatomic, strong) UIFont *itemTextFont; /* 分组标题字体，默认系统字体11号 */
@property (nonatomic, strong) UIColor *itemTextColor; /* 分组标题字体颜色，默认深灰色(darkGray) */
@property (nonatomic, assign) CGFloat itemMargin; /*  */
@property (nonatomic, assign) BOOL usingSpringAnimation; /* 菜单弹出时时是否使用弹簧动画 */
@property (nonatomic, assign) CGFloat springWithDamping; /* with spring-style springWithDamping, default is 0.7 */
@property (nonatomic, assign) CGFloat springVelocity; /* with spring-style springVelocity, default is 0.3 */

+ (AFPopUpMenuConfiguration *)defaultConfiguration;

@end

typedef void (^AFPopUpMenuDoneBlock) (NSIndexPath *selectedIndexPath);
typedef void (^AFPopUpMenuDismissBlock) (void);
typedef void (^AFPopUpMenuVoidBlock) (NSString *title);

@interface AFPopUpMenu : NSObject

+ (void)showWithMenuArray:(NSArray *)menuArray
               imageArray:(NSArray *)imageArray
                doneBlock:(AFPopUpMenuDoneBlock)doneBlock
             dismissBlock:(nullable AFPopUpMenuDismissBlock)dismissBlock;

+ (void)showWithTitle:(nullable NSString *)title
            menuArray:(NSArray *)menuArray
           imageArray:(NSArray *)imageArray
            doneBlock:(AFPopUpMenuDoneBlock)doneBlock
         dismissBlock:(nullable AFPopUpMenuDismissBlock)dismissBlock;

@end

NS_ASSUME_NONNULL_END
