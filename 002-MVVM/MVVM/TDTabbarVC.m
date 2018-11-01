/***********************************************************
 
 File name: TDTabbarVC.m
 Author:    weifangzou
 Description:
 tabbar
 
 2017/11/9: Created
 
 ************************************************************/

#import "TDTabbarVC.h"
#import "TDNavigationController.h"
#import "BidHallVC.h"
#import "ViewController.h"
@interface TDTabbarVC ()
/** 选择item */
@property (nonatomic, assign) NSInteger selectItem;

/** 竞拍大厅VC */
@property (nonatomic, strong) BidHallVC *bidHallVC;
@property (nonatomic, strong) ViewController *listVC;


@end

@implementation TDTabbarVC
#pragma mark - Life Circle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
  
    /** 竞拍大厅 */
    TDNavigationController *bidHallNVC = [[TDNavigationController alloc] initWithRootViewController:self.bidHallVC];
    [self setupViewController:bidHallNVC title:@"竞拍大厅" image:@"tabbar_auction" selectedImage:@"tabbar_auction_selected" tag:TDTabbarIndexBidHall];
    
    
    TDNavigationController *listNVC = [[TDNavigationController alloc] initWithRootViewController:self.listVC];
    [self setupViewController:listNVC title:@"列表" image:@"tabbar_auction" selectedImage:@"tabbar_auction_selected" tag:TDTabbarIndexList];
  
    self.viewControllers = @[bidHallNVC,listNVC];
    
    
 
}
#pragma mark - System Delegate Method 系统自带的代理方法

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    switch (item.tag) {
    
            
        case TDTabbarIndexBidHall:
            
            self.selectItem = TDTabbarIndexBidHall;
            
            break;
        case TDTabbarIndexList:
            
            self.selectItem = TDTabbarIndexList;
            
            break;
        
        default:
            break;
    }
}

#pragma mark - Private Method 私有方法

- (void)setupViewController:(UIViewController *)viewController
                      title:(NSString *)title
                      image:(NSString *)imageName
              selectedImage:(NSString *)selectImage
                        tag:(TDTabbarIndex)index {
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]; // 取消系统渲染
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [viewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateNormal];
    [viewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateSelected];
    
    viewController.tabBarItem.tag = index;
}

#pragma mark - Getters and Setters Method getter和setter方法


- (BidHallVC *)bidHallVC {
    if (!_bidHallVC) {
        _bidHallVC = [[BidHallVC alloc]init];
    }
    return _bidHallVC;
}
- (ViewController *)listVC {
    if (!_listVC) {
        _listVC = [[ViewController alloc]init];
    }
    return _listVC;
}


@end
