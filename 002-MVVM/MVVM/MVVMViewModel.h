//
//  MVVMViewModel.h
//  002-MVVM
//
//  Created by Cooci on 2018/4/1.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BaseViewModel.h"
@interface MVVMViewModel : BaseViewModel
/** <#Description#> */
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, copy)NSString * contentKey;

- (void)loadData;

@end
