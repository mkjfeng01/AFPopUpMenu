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

@interface AFPopUpMenuConfiguration : NSObject

@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, assign) CGFloat interval;
@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, strong) UIFont *menuTitleFont;
@property (nonatomic, strong) UIColor *menuTitleColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, assign) NSTextAlignment menuTitleAlignment;
@property (nonatomic, copy) NSString *exitText;
@property (nonatomic, strong) UIColor *exitTextColor;
@property (nonatomic, strong) UIFont *exitTextFont;
@property (nonatomic, assign) BOOL showSeparator;
@property (nonatomic, strong) UIColor *separatorColor;
@property (nonatomic, assign) BOOL showScrollIndicator;
@property (nonatomic, assign) UIEdgeInsets contentInset;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat minimumLineSpacing;
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;
@property (nonatomic, strong) UIFont *itemTextFont;
@property (nonatomic, strong) UIColor *itemTextColor;
@property (nonatomic, assign) CGFloat itemMargin;
@property (nonatomic, assign) BOOL usingSpringAnimation;
@property (nonatomic, assign) CGFloat springWithDamping;
@property (nonatomic, assign) CGFloat springVelocity;

@end

typedef void (^AFPopUpMenuDoneBlock) (NSIndexPath *selectedIndexPath);
typedef void (^AFPopUpMenuDismissBlock) (void);
typedef void (^AFPopUpMenuVoidBlock) (NSString *title);

@interface AFPopUpMenu : NSObject

+ (void)showWithMenuArray:(NSArray *)menuArray
               imageArray:(NSArray *)imageArray
                doneBlock:(AFPopUpMenuDoneBlock)doneBlock
             dismissBlock:(AFPopUpMenuDismissBlock)dismissBlock;

+ (void)showWithTitle:(NSString *)title
            menuArray:(NSArray *)menuArray
           imageArray:(NSArray *)imageArray
            doneBlock:(AFPopUpMenuDoneBlock)doneBlock
         dismissBlock:(AFPopUpMenuDismissBlock)dismissBlock;

@end
