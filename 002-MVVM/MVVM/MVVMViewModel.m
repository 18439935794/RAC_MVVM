//
//  MVVMViewModel.m
//  002-MVVM
//
//  Created by Cooci on 2018/4/1.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "MVVMViewModel.h"
#import <ReactiveObjC.h>
@implementation MVVMViewModel

- (instancetype)init{
    if (self==[super init]) {
//        [self addObserver:self forKeyPath:@"contentKey" options:NSKeyValueObservingOptionNew context:nil];

      
    }
    return self;
}
- (void)initWithBlock:(SuccessBlock)successBlock fail:(FailBlock)failBlock {
    [super initWithBlock:successBlock fail:failBlock];
    [RACObserve(self,contentKey) subscribeNext:^(id  _Nullable x) {
        NSArray *array = @[@"转账",@"信用卡",@"充值中心",@"蚂蚁借呗",@"电影票",@"滴滴出行",@"城市服务",@"蚂蚁森林"];
        NSMutableArray * mArr = [NSMutableArray arrayWithArray:array];
        [mArr removeObject: x];
        
        self.successBlock(mArr);
    }];
}
- (void)loadData {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *array = @[@"转账",@"信用卡",@"充值中心",@"蚂蚁借呗",@"电影票",@"滴滴出行",@"城市服务",@"蚂蚁森林"];

        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.dataArray addObjectsFromArray:array];
            
            self.successBlock(array);
        });
       
    });
   
    
}
//- (void)dealloc {
//
//    [self removeObserver:self forKeyPath:@"contentKey"];
//}
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//
//    NSLog(@"%@",change[NSKeyValueChangeNewKey]);
//    NSArray *array = @[@"转账",@"信用卡",@"充值中心",@"蚂蚁借呗",@"电影票",@"滴滴出行",@"城市服务",@"蚂蚁森林"];
//    NSMutableArray * mArr = [NSMutableArray arrayWithArray:array];
//    [mArr removeObject: change[NSKeyValueChangeNewKey]];
//    self.successBlock(mArr);
//}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
