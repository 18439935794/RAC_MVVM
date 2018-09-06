//
//  ViewController.m
//  002-MVVM
//
//  Created by Cooci on 2018/4/1.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "ViewController.h"
#import "MVVMViewModel.h"
#import "MVVMView.h"
#import <ReactiveObjC.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

static NSString *const reuserId = @"reuserId";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MVVMViewModel *vm;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"城市服务";
    self.vm = [[MVVMViewModel alloc]init];
    __weak  typeof (self) weakSelf = self;
    [self.vm  initWithBlock:^(id data) {
        
        NSArray * array = (NSArray *)data;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.dataArray addObjectsFromArray:array];
        MVVMView *headView = [[MVVMView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (array.count + 1)/4*50)];
        [headView headViewWithData:array];
        weakSelf.tableView.tableHeaderView = headView;
        [weakSelf.tableView reloadData];
        
    } fail:^(id data) {
        
    }];
    
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    [self addRightBar];
}
- (void)addRightBar {
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(click:)];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)click:(UIBarButtonItem *)btn {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)didClickReloadDataItem:(id)sender {
    NSLog(@"点我刷新数据");
    [self.vm loadData];

}

#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserId forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}


#pragma mark - tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.vm.contentKey = self.dataArray[indexPath.row];
}


#pragma mark - lazy

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataArray;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuserId];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
