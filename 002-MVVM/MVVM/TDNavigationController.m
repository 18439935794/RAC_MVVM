/***********************************************************
 
 File name: TDNavigationController.m
 Author:    xuwei
 Description:
 导航栏的基类
 
 2017/11/13: Created
 
 ************************************************************/

#import "TDNavigationController.h"

@interface TDNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation TDNavigationController
#pragma mark - Life Circle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationWithTitle:self.title];
    
    self.navigationController.navigationBar.translucent = NO;
    //设置右滑返回手势的代理为自身
//    __weak typeof(self) weakSelf = self;
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.interactivePopGestureRecognizer.delegate = (id)weakSelf;
//    }
}
// 这个方法是在手势将要激活前调用：返回YES允许右滑手势的激活，返回NO不允许右滑手势的激活
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
//        if (self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0]) {
//            return NO;
//        }
//    }
//    return YES;
//}

/**
 有返回按钮的导航栏
 
 @param title 导航栏的title
 */
- (void)setNavigationWithTitle:(NSString *)title {
//    [self setNavigationBarWithBGColor:@"ffffff"
//                                title:title
//                           titleColor:[UIColor whiteColor]
//                            imageName:@"common_icon_back"
//                              seletor:@selector(popViewController)];
}

/**
 pop回上一个
 */
- (void)popViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

/** 重写导航栏的push方法 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSInteger sonVC = self.viewControllers.count;
    if (sonVC > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        self.navigationBarHidden = NO;
    }
    [super pushViewController:viewController animated:NO];
}

@end
