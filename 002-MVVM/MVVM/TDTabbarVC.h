/***********************************************************
 
 File name: TDTabbarVC.h
 Author:    weifangzou
 Description:
 tabbar
 
 2017/11/9: Created
 
 ************************************************************/

#import <UIKit/UIKit.h>




// Tabbar 标签栏
typedef NS_ENUM(NSInteger, TDTabbarIndex) {
    
    TDTabbarIndexBidHall,   ///< 竞拍大厅
    
    TDTabbarIndexList   //列表  
    
};

@interface TDTabbarVC : UITabBarController

@end
