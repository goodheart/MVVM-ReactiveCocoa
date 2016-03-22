//
//  PMPersonalInfoViewModel.m
//  ReactiveCocoa
//
//  Created by majian on 16/3/22.
//  Copyright © 2016年 majian. All rights reserved.
//

#import "PMPersonalInfoViewModel.h"

typedef void(^PMFetchDataResultBlock)(NSArray * dataArrayI);

@interface PMPersonalInfoViewModel ()



@end

@implementation PMPersonalInfoViewModel



- (NSUInteger)numberOfCellInSection:(NSUInteger)section {
    return self.dataSource.count;
}

- (PMPersonalInfoModel *)modelAtSection:(NSUInteger)section row:(NSUInteger)row {
    if (section > 0 || row > self.dataSource.count - 1) {
        return nil;
    }
    
    return self.dataSource[row];
}

- (void)fetchLastestData {
    self.isLoading = YES;
    [self _fetchLastestData];
}

- (void)fetchMoreData {
    self.isLoading = YES;
    [self _fetchMoreData];
}

#pragma mark - Private Method
- (void)_fetchLastestData {
    [self _createFakeDataWithResultBlock:^(NSArray *dataArrayI) {
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:dataArrayI];
        self.isLoading = NO;
    }];
}

- (void)_fetchMoreData {
    [self _createFakeDataWithResultBlock:^(NSArray *dataArrayI) {
        [self.dataSource addObjectsFromArray:dataArrayI];
        self.isLoading = NO;
    }];
}

- (void)_createFakeDataWithResultBlock:(PMFetchDataResultBlock)resultBlock {
    dispatch_async(dispatch_queue_create(0, 0), ^{
        sleep(3);
        NSUInteger count = arc4random() % 18 + 2;
        NSArray * nameArrayI = @[@"AAA",@"BBB",@"CCC",@"DDD",@"EEE"];
        NSMutableArray * arrayM = [NSMutableArray new];
        for (NSUInteger index = 0; index < count; index++) {
            PMPersonalInfoModel * model = [[PMPersonalInfoModel alloc] init];
            NSString * name = [nameArrayI[index % nameArrayI.count] stringByAppendingFormat:@"%d",arc4random() % 100];
            NSNumber * level = @(index);
            model.name = name;
            model.level = level;
            [arrayM addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            resultBlock(arrayM);
        });
    });
}

#pragma mark - Lazy Initialization
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    
    return _dataSource;
}

@end
