//
//  ToolBar.h
//  ToolBar
//
//  Created by 鲍宇 on 16/5/18.
//  Copyright © 2016年 SanPang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ToolBar;
typedef enum {
    HMComposeToolbarButtonTypeCamera, // 照相机
    HMComposeToolbarButtonTypePicture, // 相册
    HMComposeToolbarButtonTypeMention, // 提到@
    HMComposeToolbarButtonTypeTrend, // 话题
    HMComposeToolbarButtonTypeEmotion // 表情
} HMComposeToolbarButtonType;
@protocol ToolBarDelegate <NSObject>

- (void)composeTool:(ToolBar *)toolbar didClickedButton:(HMComposeToolbarButtonType)Type;

@end
@interface ToolBar : UIView
//添加代理属性
@property (nonatomic, weak) id<ToolBarDelegate>delegate;
@end
