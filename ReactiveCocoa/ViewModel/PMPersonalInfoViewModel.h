/*!PMPersonalInfoViewModel.h

@abstract <#abstract#>

@author Created by majian on 16/3/22.

@version <#version#> 16/3/22 Creation

Copyright © 2016年 majian. All rights reserved.

*/

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "PMPersonalInfoModel.h"

/*!

@class PMPersonalInfoViewModel

@abstract <#description#>

*/
@interface PMPersonalInfoViewModel : NSObject

@property (nonatomic,assign) NSUInteger numberOfSections;
@property (nonatomic,assign) BOOL isLoading;
@property (nonatomic,strong) NSMutableArray * dataSource;
- (NSUInteger)numberOfCellInSection:(NSUInteger)section;

- (PMPersonalInfoModel *)modelAtSection:(NSUInteger)section
                                    row:(NSUInteger)row;

- (void)fetchLastestData;

- (void)fetchMoreData;

@end














