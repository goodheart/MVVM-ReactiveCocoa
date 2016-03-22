//
//  PMPersonalInfoTableViewCell.m
//  ReactiveCocoa
//
//  Created by majian on 16/3/22.
//  Copyright © 2016年 majian. All rights reserved.
//

#import "PMPersonalInfoTableViewCell.h"

@interface PMPersonalInfoTableViewCell ()

@property (nonatomic,weak) IBOutlet UILabel * nameLabel;
@property (nonatomic,weak) IBOutlet UILabel * levelLabel;

@end

@implementation PMPersonalInfoTableViewCell

- (void)setInfoModel:(PMPersonalInfoModel *)infoModel {
    _infoModel = infoModel;
    
    _nameLabel.text = infoModel.name;
    _levelLabel.text = infoModel.level.stringValue;
}

@end
