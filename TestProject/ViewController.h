//
//  ViewController.h
//  TestProject
//
//  Created by Prakshi Bector on 18/2/18.
//  Copyright © 2018 Prakshi Bector. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import "TableViewCell.h"
@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLConnectionDelegate,NSURLSessionDelegate,NSURLConnectionDataDelegate>
{
    UIRefreshControl *refreshControl;
    Location *location;
    TableViewCell *cell;
    NSArray *_locations;

}
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end

