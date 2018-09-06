
//
//  MainViewController.m
//  002-MVVM
//
//  Created by weifangzou on 2018/8/22.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "MainViewController.h"
#import "LoginView.h"
#import <ReactiveObjC.h>
#import "ViewController.h"
#import <RACReturnSignal.h>
#import <RACEXTScope.h>

@interface MainViewController ()
/** 登陆试图 */
@property (nonatomic, strong) LoginView *loginV;
/** RACKVO测试 */
@property (nonatomic, copy) NSString *name;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.loginV];
    
    //    [self addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    self.name = @"ZZ";
    [self RACGesture];
    [self signalBinding];
    [self signalDependence];
   
  
//    retry重试 ：只要失败，就会重新执行创建信号中的block,直到成功.
    __block int i = 0;
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        if (i == 10) {
            [subscriber sendNext:@1];
        }else{
            NSLog(@"接收到错误");
            [subscriber sendError:nil];
        }
        i++;
        return nil;
        
    }] retry] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    } error:^(NSError *error) {
        
    }];
    

    
    
    
 
    
}
- (void)signalCombination {
    
    
     //信号合并()
     
     RACSignal * signalA = self.loginV.userNameTextField.rac_textSignal;
     RACSignal * signalB = [self.loginV.passwordTextField rac_textSignal];
     //merge
     [[signalA merge:signalB] subscribeNext:^(id  _Nullable x) {
     NSLog(@"merge:%@",x);
     }];
     //zipWith  会把每一次的信号需求进行保存
     [[signalA zipWith:signalB]subscribeNext:^(id  _Nullable x) {
     
     NSLog(@"zipWith:合并%@",x);
     
     }];
     //    //combineLatestWith  只保存最新的一次
     [[signalA combineLatestWith:signalB]subscribeNext:^(id  _Nullable x) {
     NSLog(@"combineLatestWith:%@",x);
     
     }];
     
    
}
/**
 信号绑定
 */
- (void)signalBinding {
     @weakify(self);
    RACSignal *validUserNameSignal = [self.loginV.userNameTextField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        @strongify(self)
        return @([self isValid:value]);
    }];
    RACSignal *validPasswordSignal = [self.loginV.passwordTextField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        @strongify(self)
        return @([self isValid:value]);
    }];
    //组合-聚合   对combineLatestWith的封装
    [[RACSignal combineLatest:@[validUserNameSignal,validPasswordSignal] reduce:^id(id  valueA , id valueB){
        return @([valueA boolValue] && [valueB boolValue]);
        //        return [NSString stringWithFormat:@"%@----%@",valueA,valueB];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
        
        self.loginV.loginButton.enabled = [x boolValue];
        self.loginV.loginButton.titleLabel.textColor = [x boolValue] ? [UIColor whiteColor] : [UIColor lightGrayColor];
        
    }];
    
    [[self.loginV.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        ViewController *  vc = [ViewController new];
        UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:vc];
        
        [self presentViewController:nvc animated:YES completion:nil];
        
        
    }];
}
/**
 信号依赖
 */
- (void)signalDependence {
    
    
     //下一个网络请求 依赖上一个
     RACSignal * signalC = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
     sleep(2);
     NSLog(@"请求网络A");
     [subscriber  sendNext:@"小小蜗牛"];
     [subscriber  sendCompleted];//切记  要写这句
     return nil;
     }];
     
     //下一个网络请求 依赖上一个  then
     RACSignal * signalD = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
     
     NSLog(@"请求网络B");
     [subscriber  sendNext:@"love"];
        return nil;
     }];
     
     [[signalC then:^RACSignal * _Nonnull{
        return signalD;
     }]subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
     }];
     
     

     ///  takeUntil:终止后面
     
     RACSubject * A = [RACSubject subject];
     RACSubject * B = [RACSubject subject];
     [[A  takeUntil:B]subscribeNext:^(id  _Nullable x) {
     NSLog(@"%@",x);
     }];
     [A sendNext:@"aaa"];
    
     [B sendNext:@"bbb"];
    
    
   
    
}
- (void)filtering {
    
    //过滤
    @weakify(self);

    [[self.loginV.userNameTextField.rac_textSignal  filter:^BOOL(NSString * _Nullable value) {
        
        @strongify(self)
        // YES
        if (self.loginV.userNameTextField.text.length >6) {
            self.loginV.userNameTextField.text = [self.loginV.userNameTextField.text substringToIndex:6];
            self.loginV.weChatLab.text = @"太长了";
        }
        return value.length<6;
        
    }] subscribeNext:^(NSString * _Nullable x) {
        self.loginV.iconImg.image = [UIImage imageNamed:x];
    }];
    
}
- (void)mapTest {
    // objc_sendMSG
    //map 跟 flattenMap 是一模一样的  但是返回的数据格式不一样  一个是ID  一个是信号
    //map：id
    [[[self.loginV.userNameTextField.rac_textSignal skip:1] map:^id _Nullable(NSString * _Nullable value) {
        NSLog(@"%@",value);
        
        return [NSString stringWithFormat:@"输出map：%@",value];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"san%@",x);
    }];
    //map：RACSignal
    [[self.loginV.userNameTextField.rac_textSignal  flattenMap:^__kindof RACSignal * _Nullable(NSString * _Nullable value) {
        NSLog(@"一：%@",value);
        //value:源信号发送的内容
        value = [NSString stringWithFormat:@"输出：%@", value];
        //返回的信号:用来包装成修改内容值
        return [RACReturnSignal return:value];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"三：%@", x);
        
    }];
    
}
- (void)RACTimer {
    //冷信号
    // timer
    [[RACSignal interval:1 onScheduler:[RACScheduler  scheduler]] subscribeNext:^(NSDate * _Nullable x) {
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"执行一次");
    }];
    
    
}
- (void)RACDictionary {
    //Tuple:元组
    NSDictionary * dic = @{@"name":@"ZZ",@"age":@"22"};
    [dic.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}
- (void)RACArray {
    NSArray * array = @[@"小小书童",@"ZZ",@"糖果"];
    //GCD  数组遍历
    [array.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
        NSLog(@"%@",[NSThread currentThread]);//在子线程里执行
        
    }];
    
}
- (void)RACGesture {
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]init];
    [self.loginV.weChatLab addGestureRecognizer:tap];
    [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        NSLog(@"%@",x);
    }];
}
- (void)RACUI {
    
    [[self.loginV.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"%@",x);
    }];
}
- (void)RACDelegate {
    
    //监听textfield的代理方法
    //    [[self rac_signalForSelector:@selector(textFieldDidBeginEditing:) fromProtocol:@protocol(UITextFieldDelegate)  ] subscribeNext:^(RACTuple * _Nullable x) {
    //        NSLog(@"delegate %@",x);
    //    }];
    //    self.userTF.delegate = self;
    
    //监听textField的text
    [[self.loginV.userNameTextField.rac_textSignal skip:1] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@",x);
    }];
}
- (void)RACNotifacation {
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidHideNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"%@",x);
    }];
    
}
- (void)RACKVO {
    [RACObserve(self, name) subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.name = [NSString stringWithFormat:@"%@ + ",self.name];
}
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    NSLog(@"%@",change[NSKeyValueChangeNewKey]);
//
//}
//- (void)dealloc {
//    [self removeObserver:self forKeyPath:@"name"];
//}
- (LoginView *)loginV {
    
    if (!_loginV) {
        _loginV = [[LoginView alloc]initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, 300)];
        _loginV.center = self.view.center;
//        _loginV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _loginV;
}
- (BOOL)isValid:(NSString *)str {
    /*
     给密码定一个规则：由字母、数字和_组成的6-16位字符串
     */
    NSString *regularStr = @"[a-zA-Z0-9_]{6,16}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", regularStr];
    return [predicate evaluateWithObject:str];
}
@end
