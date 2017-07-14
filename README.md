![kGbFS.jpg](http://storage1.imgchr.com/kGbFS.jpg)

> 类似微信/QQ分享的底部弹出视图，使用简单一句话集成。

效果图：

![kJFW4.gif](http://storage1.imgchr.com/kJFW4.gif)

使用：
```
#import "AFPopUpMenu.h"

[AFPopUpMenu showWithTitle:title
                     menuArray:titleArray
                    imageArray:imageArray
                     doneBlock:^(NSIndexPath * _Nonnull selectedIndexPath) {
        // do something..
    }
                  dismissBlock:^{
        // do something..
    }];
```

AFPopUpMenu is released under the MIT license. See [LICENSE](https://mit-license.org/) for details.
