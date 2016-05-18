//
//  ViewController.m
//  ToolBar
//
//  Created by 鲍宇 on 16/5/18.
//  Copyright © 2016年 SanPang. All rights reserved.
//
#import "ToolBar.h"
#import "ViewController.h"
#import "UIView+Extension.h"
@interface ViewController ()<UITextViewDelegate,ToolBarDelegate>
@property (nonatomic, strong) ToolBar *toolbar;
@property (nonatomic, strong) UITextView *text;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITextView *text = [[UITextView alloc]init];
    text.delegate = self;
    text.alwaysBounceVertical = YES;
    text.frame = self.view.frame;
    text.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:text];
    self.text = text;
    ToolBar *toolbar = [[ToolBar alloc]init];
    
    toolbar.width = self.view.size.width;
    toolbar.height = 44;
    toolbar.x = 0;
    toolbar.y = self.view.height - toolbar.height;
    [text addSubview:toolbar];
    self.toolbar = toolbar;
    self.toolbar.delegate = self;
    
    // 4.监听键盘
    // 键盘的frame(位置)即将改变, 就会发出UIKeyboardWillChangeFrameNotification
    // 键盘即将弹出, 就会发出UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘即将隐藏, 就会发出UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        // 取出键盘高度
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, - keyboardH);
    }];
}
- (void)keyboardWillHide:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
}
#pragma mark - UITextViewDelegate
/**
 *  当用户开始拖拽scrollView时调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
#pragma mark - HMComposeToolbarDelegate
/**
 *  监听toolbar内部按钮的点击
 */
- (void)composeTool:(ToolBar *)toolbar didClickedButton:(HMComposeToolbarButtonType)Type
{
    switch (Type) {
        case HMComposeToolbarButtonTypeCamera: // 照相机
            NSLog(@"相机");
            break;
            
        case HMComposeToolbarButtonTypePicture: // 相册
           NSLog(@"相册");
            break;
            
        case HMComposeToolbarButtonTypeEmotion: // 表情
           NSLog(@"表情");
            break;
            
        default:
            break;
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    // 成为第一响应者（叫出键盘）
    [self.text becomeFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
