//
//  ViewController.h
//  TestProject
//
//  Created by Prakshi Bector on 18/2/18.
//  Copyright © 2018 Prakshi Bector. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLConnectionDelegate,NSURLSessionDelegate,NSURLConnectionDataDelegate>
{
    UIRefreshControl *refreshControl;
    Location *location;
    NSArray *_locations;

}
-(void)callJsonData;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UILabel *descLabl;
@property (nonatomic, strong) IBOutlet UILabel *titleLbl;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;

@end

