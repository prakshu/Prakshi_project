//
//  TableViewCell.m
//  firstApp
//
//  Created by Prakshi Bector on 26/1/18.
//  Copyright © 2018 Prakshi Bector. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell
@synthesize nameLabel = _nameLabel;
@synthesize descLabel = _descLabel;
@synthesize thumbnailImageView = _thumbnailImageView;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
