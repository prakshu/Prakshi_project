//
//  TableViewCell.h
//  firstApp
//
//  Created by Prakshi Bector on 26/1/18.
//  Copyright © 2018 Prakshi Bector. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *descLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;
@end
