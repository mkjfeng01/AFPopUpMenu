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

#define AF_DEVICE_SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define AF_DEVICE_SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define AFPopUpMenuCancelSelectedIndexPath [NSIndexPath indexPathForRow:-1 inSection:-1]
#define AFVersionNumber_iOS_8_0_Later kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0

#ifndef AFLocalizedStrings
#define AFLocalizedStrings(key) \
    NSLocalizedStringFromTableInBundle((key), @"AFPopUpMenuString", [NSBundle bundleWithPath:[[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent:@"AFPopUpMenu.bundle"]], nil)
#endif

#import <UIKit/UIKit.h>
#import "AFPopUpMenu.h"

static NSString * const AFPopUpMenuImageCacheDirectory = @"com.af.AFPopUpMenuImageCacheDirectory";
static NSString * const AFPopUpMenuCellIdentifier = @"com.af.AFPopUpMenuCellIdentifier";

#pragma mark - NSString (AFPopUpMenu)
///=============================================================================
/// @name NSString (AFPopUpMenu)
///=============================================================================

@interface NSString (AFPopUpMenu)

@end

@implementation NSString (AFPopUpMenu)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:self
                                                                         attributes:@{NSFontAttributeName:font}];
    
    return [attributedText boundingRectWithSize:maxSize
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                        context:nil].size;
}

@end

#pragma mark - AFPopUpMenuConfiguration
///=============================================================================
/// @name AFPopUpMenuConfiguration
///=============================================================================

@interface AFPopUpMenuConfiguration ()

@end

@implementation AFPopUpMenuConfiguration

+ (AFPopUpMenuConfiguration *)defaultConfiguration {
    static dispatch_once_t onceToken;
    static AFPopUpMenuConfiguration *configuration;
    dispatch_once(&onceToken, ^{
        configuration = [[AFPopUpMenuConfiguration alloc] init];
    });
    return configuration;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.minimumLineSpacing = 5.f;
        self.minimumInteritemSpacing = 0.f;
        self.springWithDamping = 0.7f;
        self.springVelocity = 0.3f;
        
        self.menuTitleFont = [UIFont systemFontOfSize:12.f];
        self.exitTextFont = [UIFont systemFontOfSize:15.f];
        self.itemTextFont = [UIFont systemFontOfSize:11.f];
        
        self.menuBackgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.75f];
        self.menuTitleColor = [UIColor darkGrayColor];
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.3f];
        self.exitTextColor = [UIColor darkGrayColor];
        self.itemTextColor = [UIColor darkGrayColor];
        self.separatorColor = [UIColor colorWithRed:210/255.f green:210/255.f blue:210/255.f alpha:1];
        
        self.exitText = AFLocalizedStrings(@"Cancel");
        
        self.blurEffectAvailable = AFVersionNumber_iOS_8_0_Later;
        self.showSeparator = YES;
        self.showScrollIndicator = NO;
        self.usingSpringAnimation = NO;
        
        self.animationDuration = .3f;
        
        self.menuTitleAlignment = NSTextAlignmentLeft;
        
    }
    return self;
}

@end


#pragma mark - AFPopUpMenuFrameFactory
///=============================================================================
/// @name AFPopUpMenuFrameFactory
///=============================================================================

@interface AFPopUpMenuFrameFactory : NSObject

@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, assign) CGFloat interval;
@property (nonatomic, assign) CGFloat itemMargin;
@property (nonatomic, assign) CGFloat itemContentViewHeight;
@property (nonatomic, assign) CGFloat exitButtonHeihgt;
@property (nonatomic, assign) CGFloat seperatorHeihgt;
@property (nonatomic, assign) UIEdgeInsets contentInset;

@property (nonatomic, assign) CGRect menuFrame;
@property (nonatomic, assign) CGRect titleLabelFrame;
@property (nonatomic, assign) CGRect upsideContentViewFrame;
@property (nonatomic, assign) CGRect bottomContentViewFrame;
@property (nonatomic, assign) CGRect separatorFrame;
@property (nonatomic, assign) CGRect exitButtonFrame;
@property (nonatomic, assign) CGFloat transformOffset;

@end

@implementation AFPopUpMenuFrameFactory

+ (AFPopUpMenuFrameFactory *)sharedFactory {
    static dispatch_once_t onceToken;
    static AFPopUpMenuFrameFactory *factory;
    dispatch_once(&onceToken, ^{
        factory = [[AFPopUpMenuFrameFactory alloc] init];
    });
    return factory;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.itemMargin = 5.f;
        self.itemSize = CGSizeMake(70.f, 110.f);
        self.margin = 15.f;
        self.interval = 10.f;
        self.itemContentViewHeight = 110.f;
        self.exitButtonHeihgt = 50.f;
        self.seperatorHeihgt = 0.5;
        self.contentInset = UIEdgeInsetsMake(0.f, 10.f, 0.f, 10.f);
    }
    return self;
}

@end


#pragma mark - AFPopUpMenuCell
///=============================================================================
/// @name AFPopUpMenuCell
///=============================================================================

@interface AFPopUpMenuCell : UICollectionViewCell

@property (nonatomic, strong) UIButton *iconImageButton;
@property (nonatomic, strong) UILabel *menuNameLabel;
@property (nonatomic, copy) AFPopUpMenuHitBlock doneBlock;

@end

@implementation AFPopUpMenuCell

+ (instancetype)dequeueReusableCellWithCollectionView:(UICollectionView *)collectionView reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath {
    AFPopUpMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}

- (void)setupWithMenuName:(NSString *)menuName menuImage:(id)menuImage {
    [self.contentView addSubview:self.iconImageButton];
    [self.contentView addSubview:self.menuNameLabel];
    
    self.menuNameLabel.text = menuName;
    
    CGFloat margin = [AFPopUpMenuFrameFactory sharedFactory].itemMargin;
    CGFloat interval = [AFPopUpMenuFrameFactory sharedFactory].interval;
    CGFloat itemWidth = [AFPopUpMenuFrameFactory sharedFactory].itemSize.width;
    CGFloat itemHeight = [AFPopUpMenuFrameFactory sharedFactory].itemSize.height;
    
    CGSize maxSize = CGSizeMake(itemWidth - 2 * margin, itemHeight - (interval + itemWidth - margin * 2));
    CGSize size = [menuName sizeWithFont:[AFPopUpMenuConfiguration defaultConfiguration].itemTextFont
                                 maxSize:maxSize];
    self.menuNameLabel.frame = CGRectMake(margin, interval + (itemWidth - margin * 2) + margin, itemWidth - margin * 2, size.height);
    
    CGRect rect = CGRectMake(margin, interval, CGRectGetWidth(self.menuNameLabel.frame), itemWidth - margin * 2);
    [self.iconImageButton setFrame:rect];
    
    [self getImageWithResource:menuImage completion:^(UIImage *image) {
        [_iconImageButton setBackgroundImage:image forState:UIControlStateNormal];
    }];
}

- (void)getImageWithResource:(id)resource completion:(void (^)(UIImage *image))completion {
    if ([resource isKindOfClass:[UIImage class]]) {
        completion(resource);
    } else if ([resource isKindOfClass:[NSString class]]) {
        if ([resource hasPrefix:@"http"]) {
            [self downloadImageWithURL:[NSURL URLWithString:resource] completion:completion];
        } else {
            completion([UIImage imageNamed:resource]);
        }
    } else if ([resource isKindOfClass:[NSURL class]]) {
        [self downloadImageWithURL:resource completion:completion];
    } else {
        NSLog(@"Image resource not recougnized.");
        completion(nil);
    }
}

- (void)downloadImageWithURL:(NSURL *)url completion:(void (^)(UIImage *image))completion {
    if ([self isExitImageForImageURL:url]) {
        NSString *filePath = [self filePathForImageURL:url];
        completion([UIImage imageWithContentsOfFile:filePath]);
    } else {
        // download
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
            if (image) {
                NSData *data = UIImagePNGRepresentation(image);
                [data writeToFile:[self filePathForImageURL:url] atomically:YES];
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(image);
                });
            }
        });
    }
}

- (BOOL)isExitImageForImageURL:(NSURL *)url {
    return [[NSFileManager defaultManager] fileExistsAtPath:[self filePathForImageURL:url]];
}

- (NSString *)filePathForImageURL:(NSURL *)url {
    NSString *diskCachePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:AFPopUpMenuImageCacheDirectory];
    if(![[NSFileManager defaultManager] fileExistsAtPath:diskCachePath]){
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:diskCachePath
                                  withIntermediateDirectories:YES
                                                   attributes:@{}
                                                        error:&error];
    }
    NSData *data = [url.absoluteString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *pathComponent = [data base64EncodedStringWithOptions:NSUTF8StringEncoding];
    NSString *filePath = [diskCachePath stringByAppendingPathComponent:pathComponent];
    return filePath;
}

- (void)iconImageButtonPressed:(id)sender {
    !self.doneBlock ?: self.doneBlock(self.menuNameLabel.text);
}

- (UIButton *)iconImageButton {
    if (_iconImageButton == nil) {
        UIButton *iconImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [iconImageButton addTarget:self action:@selector(iconImageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        _iconImageButton = iconImageButton;
    }
    return _iconImageButton;
}

- (UILabel *)menuNameLabel {
    if (_menuNameLabel == nil) {
        UILabel *menuNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        menuNameLabel.textAlignment = NSTextAlignmentCenter;
        menuNameLabel.numberOfLines = 2;
        menuNameLabel.font = [AFPopUpMenuConfiguration defaultConfiguration].itemTextFont;
        menuNameLabel.textColor = [AFPopUpMenuConfiguration defaultConfiguration].itemTextColor;
        _menuNameLabel = menuNameLabel;
    }
    return _menuNameLabel;
}

@end


#pragma mark - AFPopUpMenuCollectionView
///=============================================================================
/// @name AFPopUpMenuCollectionView
///=============================================================================

@interface AFPopUpMenuCollectionView : UICollectionView <NSCopying>

@end

@implementation AFPopUpMenuCollectionView

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

@end

#pragma mark - AFPopUpMenuView
///=============================================================================
/// @name AFPopUpMenuView
///=============================================================================

@interface AFPopUpMenuView : UIView <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *titleFactoryArray;
@property (nonatomic, strong) NSArray *imageFactoryArray;
@property (nonatomic, copy) AFPopUpMenuDoneBlock doneBlock;

@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *seperator;
@property (nonatomic, strong) UIButton *exitButton;
@property (nonatomic, strong) AFPopUpMenuCollectionView *upsideContentView;
@property (nonatomic, strong) AFPopUpMenuCollectionView *bottomContentView;

@property (nonatomic, assign) BOOL showMenuTitle;
@property (nonatomic, assign) NSUInteger popUpMenuSection;
@property (nonatomic, strong) NSMutableDictionary <id, NSNumber *> *mutableContentViewForIndexPathStore;

@end

@implementation AFPopUpMenuView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger index = [self cachedStoreSectionForKey:collectionView];
    return [self.titleFactoryArray[index] count];
}

- (NSUInteger)popUpMenuSection {
    return self.titleFactoryArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id menuImage;
    NSString *menuTitle;
    
    AFPopUpMenuCell *cell = [AFPopUpMenuCell dequeueReusableCellWithCollectionView:collectionView reuseIdentifier:AFPopUpMenuCellIdentifier indexPath:indexPath];
    
    NSUInteger section = [self cachedStoreSectionForKey:collectionView];
    menuTitle = self.titleFactoryArray[section][indexPath.row];
    menuImage = self.imageFactoryArray[section][indexPath.row];
    
    __weak __typeof(self) weakSelf = self;
    cell.doneBlock = ^(NSString *title){
        NSInteger row = [self.titleFactoryArray[section] indexOfObject:title];
        !weakSelf.doneBlock ?: weakSelf.doneBlock([NSIndexPath indexPathForRow:row inSection:section]);
    };
    
    [cell setupWithMenuName:menuTitle menuImage:menuImage];
    
    return cell;
}

- (void)popUpMenuWithTitle:(NSString *)title menuArray:(NSArray *)menuArray menuImageArray:(NSArray *)menuImageArray doneBlock:(AFPopUpMenuDoneBlock)doneBlock {
    _title = title;
    _titleFactoryArray = menuArray;
    _imageFactoryArray = menuImageArray;
    _doneBlock = doneBlock;
    _mutableContentViewForIndexPathStore = [NSMutableDictionary dictionary];
    
    UIView *contentView = self;
    if ([AFPopUpMenuConfiguration defaultConfiguration].blurEffectAvailable) {
        [self addSubview:self.visualEffectView];
        // FIXME:Use `visualEffectView.contentView` instead of `visualEffectView`.
        contentView = self.visualEffectView.contentView;
    }
    
    if (self.showMenuTitle) { [contentView addSubview:self.titleLabel]; }
    [contentView addSubview:self.upsideContentView];
    
    self.mutableContentViewForIndexPathStore[self.upsideContentView] = @(0);
    
    if (self.popUpMenuSection == 2) {
        if ([AFPopUpMenuConfiguration defaultConfiguration].showSeparator) {
            [contentView addSubview:self.seperator];
        }
        [contentView addSubview:self.bottomContentView];
        self.mutableContentViewForIndexPathStore[self.bottomContentView] = @(1);
    }
    [contentView addSubview:self.exitButton];
    contentView.backgroundColor = [AFPopUpMenuConfiguration defaultConfiguration].menuBackgroundColor;
    
    [self shouldUpdateMenuViewFrame];
}

- (void)shouldUpdateMenuViewFrame {
    self.frame = [AFPopUpMenuFrameFactory sharedFactory].menuFrame;
    
    if ([AFPopUpMenuConfiguration defaultConfiguration].blurEffectAvailable) {
        self.visualEffectView.frame = self.bounds;
    }
    
    if (self.showMenuTitle) { self.titleLabel.frame = [AFPopUpMenuFrameFactory sharedFactory].titleLabelFrame; }
    self.upsideContentView.frame = [AFPopUpMenuFrameFactory sharedFactory].upsideContentViewFrame;
    if (self.popUpMenuSection == 2) {
        self.seperator.frame = [AFPopUpMenuFrameFactory sharedFactory].separatorFrame;
        self.bottomContentView.frame = [AFPopUpMenuFrameFactory sharedFactory].bottomContentViewFrame;
    }
    self.exitButton.frame = [AFPopUpMenuFrameFactory sharedFactory].exitButtonFrame;
}

- (void)exitButtonPressed {
    !self.doneBlock ?: self.doneBlock(AFPopUpMenuCancelSelectedIndexPath);
}

#pragma mark - Methods (Private)

- (BOOL)showMenuTitle {
    return self.title.length > 0;
}

- (NSUInteger)cachedStoreSectionForKey:(id)key {
    if (!key) {
        return 0;
    }
    
    return [self.mutableContentViewForIndexPathStore[key] unsignedIntegerValue];
}

#pragma mark - Methods (Lazy Load)

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.text = self.title;
        titleLabel.numberOfLines = 0;
        titleLabel.font = [AFPopUpMenuConfiguration defaultConfiguration].menuTitleFont;
        titleLabel.textAlignment = [AFPopUpMenuConfiguration defaultConfiguration].menuTitleAlignment;
        titleLabel.textColor = [AFPopUpMenuConfiguration defaultConfiguration].menuTitleColor;
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (UIVisualEffectView *)visualEffectView {
    if (_visualEffectView == nil) {
        UIBlurEffect *visualEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:visualEffect];
        _visualEffectView = visualEffectView;
    }
    return _visualEffectView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = [AFPopUpMenuFrameFactory sharedFactory].itemSize;
    flowLayout.minimumLineSpacing = [AFPopUpMenuConfiguration defaultConfiguration].minimumLineSpacing;
    flowLayout.minimumInteritemSpacing = [AFPopUpMenuConfiguration defaultConfiguration].minimumLineSpacing;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return flowLayout;
}

- (UIView *)seperator {
    if (_seperator == nil) {
        UIView *seperator = [[UIView alloc] initWithFrame:CGRectZero];
        seperator.backgroundColor = [AFPopUpMenuConfiguration defaultConfiguration].separatorColor;
        _seperator = seperator;
    }
    return _seperator;
}

- (AFPopUpMenuCollectionView *)upsideContentView {
    if (_upsideContentView == nil) {
        AFPopUpMenuCollectionView *upsideContentView = [[AFPopUpMenuCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[self flowLayout]];
        upsideContentView.backgroundColor = [UIColor clearColor];
        upsideContentView.showsHorizontalScrollIndicator = [AFPopUpMenuConfiguration defaultConfiguration].showScrollIndicator;
        upsideContentView.contentInset = [AFPopUpMenuFrameFactory sharedFactory].contentInset;
        upsideContentView.delegate = self;
        upsideContentView.dataSource = self;
        [upsideContentView registerClass:[AFPopUpMenuCell class] forCellWithReuseIdentifier:AFPopUpMenuCellIdentifier];
        _upsideContentView = upsideContentView;
    }
    return _upsideContentView;
}

- (AFPopUpMenuCollectionView *)bottomContentView {
    if (_bottomContentView == nil) {
        AFPopUpMenuCollectionView *bottomContentView = [[AFPopUpMenuCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[self flowLayout]];
        bottomContentView.showsHorizontalScrollIndicator = [AFPopUpMenuConfiguration defaultConfiguration].showScrollIndicator;
        bottomContentView.backgroundColor = [UIColor clearColor];
        bottomContentView.contentInset = [AFPopUpMenuFrameFactory sharedFactory].contentInset;
        bottomContentView.delegate = self;
        bottomContentView.dataSource = self;
        [bottomContentView registerClass:[AFPopUpMenuCell class] forCellWithReuseIdentifier:AFPopUpMenuCellIdentifier];
        _bottomContentView = bottomContentView;
    }
    return _bottomContentView;
}

- (UIButton *)exitButton {
    if (_exitButton == nil) {
        UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        exitButton.backgroundColor = [UIColor whiteColor];
         [exitButton addTarget:self action:@selector(exitButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [exitButton setTitle:[AFPopUpMenuConfiguration defaultConfiguration].exitText forState:UIControlStateNormal];
        [exitButton setTitleColor:[AFPopUpMenuConfiguration defaultConfiguration].exitTextColor forState:UIControlStateNormal];
        exitButton.titleLabel.font = [AFPopUpMenuConfiguration defaultConfiguration].exitTextFont;
        _exitButton = exitButton;
    }
    return _exitButton;
}

@end

#pragma mark - AFPopUpMenu
///=============================================================================
/// @name AFPopUpMenu
///=============================================================================

@interface AFPopUpMenu ()

@property (nonatomic, strong) UIControl *backgroundView;
@property (nonatomic, strong) AFPopUpMenuView *popMenuView;
@property (nonatomic, copy) AFPopUpMenuDoneBlock doneBlock;
@property (nonatomic, copy) AFPopUpMenuDismissBlock dismissBlock;

@property (nonatomic, copy) NSString *menuTitle;
@property (nonatomic, strong) NSArray <NSArray *> *menuArray;
@property (nonatomic, strong) NSArray <NSArray *> *menuImageArray;

@property (nonatomic, assign) BOOL shouldDisplayMenuTitle;
@property (nonatomic, assign) NSUInteger popUpMenuSection;

@end

@implementation AFPopUpMenu

+ (AFPopUpMenu *)sharedInstance {
    static AFPopUpMenu *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[AFPopUpMenu alloc] init];
    });
    return shared;
}

+ (void)showWithMenuArray:(NSArray *)menuArray imageArray:(NSArray *)imageArray doneBlock:(AFPopUpMenuDoneBlock)doneBlock dismissBlock:(AFPopUpMenuDismissBlock)dismissBlock {
    [[self sharedInstance] showWithTitle:nil menuArray:menuArray imageArray:imageArray doneBlock:doneBlock dismissBlock:dismissBlock];
}

+ (void)showWithTitle:(NSString *)title menuArray:(NSArray *)menuArray imageArray:(NSArray *)imageArray doneBlock:(AFPopUpMenuDoneBlock)doneBlock dismissBlock:(AFPopUpMenuDismissBlock)dismissBlock {
    [[self sharedInstance] showWithTitle:title menuArray:menuArray imageArray:imageArray doneBlock:doneBlock dismissBlock:dismissBlock];
}

- (void)showWithTitle:(NSString *)title menuArray:(NSArray *)menuArray imageArray:(NSArray *)imageArray doneBlock:(AFPopUpMenuDoneBlock)doneBlock dismissBlock:(AFPopUpMenuDismissBlock)dismissBlock {
    if ([self filterErrorWithMenuArray:menuArray imageArray:imageArray]) {
        @throw [NSException exceptionWithName:@"Parameters initial fail."
                                       reason:@"Parameters must be initial equaly."
                                     userInfo:nil];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.backgroundView addSubview:self.popMenuView];
        [[self backgroundWindow] addSubview:self.backgroundView];
        
        _menuTitle = title;
        _menuArray = menuArray;
        _menuImageArray = imageArray;
        _doneBlock = doneBlock;
        _dismissBlock = dismissBlock;
        
        [self setupPopUpMenuFrame];
    });
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onChangeStatusBarOrientationNotification:)
                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notification

- (void)onChangeStatusBarOrientationNotification:(NSNotification *)notification {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(0.2 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       [self setupPopUpMenuFrame];
                   });
}

#pragma mark - Layout

- (void)setupPopUpMenuFrame {
    self.backgroundView.frame = [UIScreen mainScreen].bounds;
    
    CGFloat margin = [AFPopUpMenuFrameFactory sharedFactory].margin;
    CGFloat interval = [AFPopUpMenuFrameFactory sharedFactory].interval;
    
    CGFloat upsideContentViewY = margin;
    
    if (self.shouldDisplayMenuTitle) {
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self.menuTitle
                                                                               attributes:@{NSFontAttributeName : [AFPopUpMenuConfiguration defaultConfiguration].menuTitleFont}];
        
        CGRect rect = [attributedString boundingRectWithSize:(CGSize){AF_DEVICE_SCREEN_WIDTH - 2 * margin, 999}
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                     context:nil];
        CGRect titleRect = CGRectMake(margin, 5, AF_DEVICE_SCREEN_WIDTH - 2 * margin, rect.size.height);
        [AFPopUpMenuFrameFactory sharedFactory].titleLabelFrame = titleRect;
        
        upsideContentViewY += CGRectGetMaxY(titleRect);
    }
    
    CGRect upsideContentViewRect = CGRectMake(0, upsideContentViewY, AF_DEVICE_SCREEN_WIDTH, [AFPopUpMenuFrameFactory sharedFactory].itemContentViewHeight);
    [AFPopUpMenuFrameFactory sharedFactory].upsideContentViewFrame = upsideContentViewRect;
    
    CGFloat exitButtonY = CGRectGetMaxY(upsideContentViewRect) + margin;
    
    if (self.popUpMenuSection == 2) {
        CGRect seperatorRect = CGRectMake(0, interval+CGRectGetMaxY(upsideContentViewRect), AF_DEVICE_SCREEN_WIDTH, [AFPopUpMenuFrameFactory sharedFactory].seperatorHeihgt);
        [AFPopUpMenuFrameFactory sharedFactory].separatorFrame = seperatorRect;
        
        CGRect bottomContentViewRect = CGRectMake(0, interval + CGRectGetMaxY(seperatorRect), AF_DEVICE_SCREEN_WIDTH, [AFPopUpMenuFrameFactory sharedFactory].itemContentViewHeight);
        [AFPopUpMenuFrameFactory sharedFactory].bottomContentViewFrame = bottomContentViewRect;
        
        exitButtonY = CGRectGetMaxY(bottomContentViewRect) + margin;
    }
    
    CGRect exitButtonRect = CGRectMake(0, exitButtonY, AF_DEVICE_SCREEN_WIDTH, [AFPopUpMenuFrameFactory sharedFactory].exitButtonHeihgt);
    [AFPopUpMenuFrameFactory sharedFactory].exitButtonFrame = exitButtonRect;
    
    [AFPopUpMenuFrameFactory sharedFactory].menuFrame = CGRectMake(0, AF_DEVICE_SCREEN_HEIGHT, AF_DEVICE_SCREEN_WIDTH, CGRectGetMaxY(exitButtonRect));
    [AFPopUpMenuFrameFactory sharedFactory].transformOffset = CGRectGetMaxY(exitButtonRect);
    
    [self setupPopUpMenuView];
}

- (void)setupPopUpMenuView {
    [self prepareToShowWithMenuTitle:self.menuTitle
                           menuArray:self.menuArray
                      menuImageArray:self.menuImageArray];
    
    [self show];
}

- (void)prepareToShowWithMenuTitle:(NSString *)title menuArray:(NSArray *)menuArray menuImageArray:(NSArray *)menuImageArray {
    _popMenuView.transform = CGAffineTransformIdentity;
    
    [_popMenuView popUpMenuWithTitle:title menuArray:menuArray menuImageArray:menuImageArray doneBlock:^(NSIndexPath *selectedIndexPath) {
        [self doneActionWithSelectedIndex:selectedIndexPath];
    }];
}

#pragma mark - Animations

- (void)show {
    if ([AFPopUpMenuConfiguration defaultConfiguration].usingSpringAnimation) {
        [UIView animateWithDuration:[AFPopUpMenuConfiguration defaultConfiguration].animationDuration
                              delay:0
             usingSpringWithDamping:[AFPopUpMenuConfiguration defaultConfiguration].springWithDamping
              initialSpringVelocity:[AFPopUpMenuConfiguration defaultConfiguration].springVelocity
                            options:0
                         animations:^{
                             self.backgroundView.alpha = 1;
                             self.popMenuView.transform = CGAffineTransformMakeTranslation(0., -[AFPopUpMenuFrameFactory sharedFactory].transformOffset);
                         } completion:NULL];
    } else {
        [UIView animateWithDuration:[AFPopUpMenuConfiguration defaultConfiguration].animationDuration
                         animations:^{
                             self.backgroundView.alpha = 1;
                             self.popMenuView.transform = CGAffineTransformMakeTranslation(0., -[AFPopUpMenuFrameFactory sharedFactory].transformOffset);
                         }];
    }
}

- (void)dismiss {
    [self doneActionWithSelectedIndex:AFPopUpMenuCancelSelectedIndexPath];
}

- (void)doneActionWithSelectedIndex:(NSIndexPath *)selectedIndexPath {
    [UIView animateWithDuration:[AFPopUpMenuConfiguration defaultConfiguration].animationDuration
                     animations:^{
        self.backgroundView.alpha = 0;
        self.popMenuView.transform = CGAffineTransformMakeTranslation(0., [AFPopUpMenuFrameFactory sharedFactory].transformOffset);
    }
                     completion:^(BOOL finished) {
        if (finished) {
            [self.popMenuView removeFromSuperview];
            [self.backgroundView removeFromSuperview];
            
            if ([selectedIndexPath isEqual:AFPopUpMenuCancelSelectedIndexPath]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    !self.dismissBlock ?: self.dismissBlock();
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    !self.doneBlock ?: self.doneBlock(selectedIndexPath);
                });
            }
            
            self.popMenuView = nil;
            self.backgroundView = nil;
        }
    }];
}

#pragma mark - Methods (Private)

- (BOOL)filterErrorWithMenuArray:(NSArray *)menuArray imageArray:(NSArray *)imageArray {
    for (id obj in menuArray) {
        if (![obj isKindOfClass:[NSArray class]]) return YES;
    }
    for (id obj in imageArray) {
        if (![obj isKindOfClass:[NSArray class]]) return YES;
    }
    if (menuArray.count != imageArray.count) return YES;
    
    return NO;
}

- (BOOL)shouldDisplayMenuTitle {
    return self.menuTitle.length > 0;
}

- (void)backgroundViewTapped {
    [self dismiss];
}

#pragma mark - Methods (Lazy Load)

- (NSUInteger)popUpMenuSection {
    return self.menuArray.count;
}

- (UIWindow *)backgroundWindow {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
    if (window == nil && [delegate respondsToSelector:@selector(window)]) {
        window = [delegate performSelector:@selector(window)];
    }
    return window;
}

- (UIControl *)backgroundView {
    if (_backgroundView == nil) {
        UIControl *backgroundView = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        backgroundView.alpha = 0;
        backgroundView.backgroundColor = [AFPopUpMenuConfiguration defaultConfiguration].backgroundColor;
        [backgroundView addTarget:self action:@selector(backgroundViewTapped) forControlEvents:UIControlEventTouchDown];
        _backgroundView = backgroundView;
    }
    return _backgroundView;
}

- (AFPopUpMenuView *)popMenuView {
    if (_popMenuView == nil) {
        AFPopUpMenuView *popMenuView = [[AFPopUpMenuView alloc] initWithFrame:CGRectZero];
        _popMenuView = popMenuView;
    }
    return _popMenuView;
}

@end
