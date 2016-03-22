//
//  ViewController.m
//  ReactiveCocoa
//
//  Created by majian on 16/3/22.
//  Copyright © 2016年 majian. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "PMPersonalInfoViewModel.h"
#import "PMPersonalInfoTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource> {
    NSString * _cellReuseIdentifier;
}

@property (nonatomic,weak) IBOutlet UITableView * tableView;
@property (nonatomic,strong) PMPersonalInfoViewModel * viewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[PMPersonalInfoViewModel alloc] init];
    _cellReuseIdentifier = NSStringFromClass([PMPersonalInfoTableViewCell class]);
    [self.tableView registerNib:[UINib nibWithNibName:_cellReuseIdentifier bundle:nil] forCellReuseIdentifier:_cellReuseIdentifier];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"load lastest" style:UIBarButtonItemStylePlain target:self.viewModel action:@selector(fetchLastestData)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"load more" style:UIBarButtonItemStylePlain target:self.viewModel action:@selector(fetchMoreData)];
    
    @weakify(self);
    [RACObserve(self.viewModel, isLoading) subscribeNext:^(NSNumber * isLoading) {
        @strongify(self);
        self.navigationItem.leftBarButtonItem.enabled = self.navigationItem.rightBarButtonItem.enabled = !isLoading.boolValue;
    }];
    
    [[[RACSignal combineLatest:@[RACObserve(self.viewModel, dataSource),
      RACObserve(self.viewModel, isLoading)]] bufferWithTime:0.1 onScheduler:[RACScheduler mainThreadScheduler]]
     subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfCellInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PMPersonalInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:_cellReuseIdentifier forIndexPath:indexPath];
    
    cell.infoModel = [self.viewModel modelAtSection:indexPath.section
                                                row:indexPath.row];
    return cell;
}


@end









