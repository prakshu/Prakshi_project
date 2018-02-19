//
//  ViewController.m
//  TestProject
//
//  Created by Prakshi Bector on 18/2/18.
//  Copyright © 2018 Prakshi Bector. All rights reserved.
//

#import "ViewController.h"
#import "Location.h"
#import "JSONLoader.h"
#import "UIImageView+WebCache.h"
#import "TableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[UIDevice currentDevice] userInterfaceIdiom] ==
        UIUserInterfaceIdiomPad && [UIScreen mainScreen].bounds.size.height == 621)
    {
//        [scrlview setContentSize:CGSizeMake(320, 800)];
        self.tableView.frame=CGRectMake(0, 0, 1242, 2208);
    }
    else if ([[UIDevice currentDevice] userInterfaceIdiom] ==
             UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 320)
    {
        //        [scrlview setContentSize:CGSizeMake(320, 800)];
        self.tableView.frame=CGRectMake(0, 0, 640, 1136);
    }
    else if ([[UIDevice currentDevice] userInterfaceIdiom] ==
        UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 375)
    {
        //        [scrlview setContentSize:CGSizeMake(320, 800)];
        self.tableView.frame=CGRectMake(0, 0, 750, 1334);
    }
   else if ([[UIDevice currentDevice] userInterfaceIdiom] ==
        UIUserInterfaceIdiomPad && [UIScreen mainScreen].bounds.size.height == 1024)
    {
        //        [scrlview setContentSize:CGSizeMake(320, 800)];
        self.tableView.frame=CGRectMake(0, 0, 2048, 2732);
    }
   else if ([[UIDevice currentDevice] userInterfaceIdiom] ==
            UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 621)
   {
//
//        scrlview.frame = CGRectMake(0, 20, 320, 423);
//        [scrlview setContentSize:CGSizeMake(320, 800)];
        
    }

    refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    //navigation title through json
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Displaydata" ofType:@"json"]];
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSString *titleHolderString = [dataDictionary objectForKey:@"title"];
   self.navigationItem.title = titleHolderString;

    //call json data
    [self callJsonData];
   
}
-(void)refreshTable
{
    [self callJsonData];
    [refreshControl endRefreshing];


    
}

-(void)callJsonData
{
    // Create a new JSONLoader with a local file URL
    JSONLoader *jsonLoader = [[JSONLoader alloc] init];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Displaydata" withExtension:@"json"];
    
    // Load the data on a background queue...
    // As we are using a local file it's not really necessary, but if we were connecting to an online URL then we'd need it
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _locations = [jsonLoader locationsFromJSONFile:url];
        // Now that we have the data, reload the table data on the main UI thread
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    });
    

}


#pragma mark - Table View Controller Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    Location *location = [_locations objectAtIndex:indexPath.row];
    id displayNameTypeValue = location.Descriptrion;
    id nameType = location.Title;
    id imgType = location.url;
    
    if ( displayNameTypeValue == [NSNull null])
    {
        cell.descLabel.text = @"";
        
    }
    else
    {
        int myLength = [location.Descriptrion length];
        cell.descLabel.text = location.Descriptrion;
        if(location.Descriptrion.length>172)
        {
            cell.descLabel.text = location.Descriptrion;
            self.tableView.rowHeight=150;
            cell.descLabel.frame=CGRectMake(81, 15, 290, 150);
        }
        else{
            self.tableView.rowHeight=90;
            cell.descLabel.frame=CGRectMake(81, 18, 290, 70);

        }
        
        NSLog( @"lenghth is %d",myLength );
    }
    if ( nameType == [NSNull null])
    {
        cell.nameLabel.text = @"";
        
    }
    else
    {
        cell.nameLabel.text = location.Title;
        
    }
    if ( imgType == [NSNull null])
    {
        cell.thumbnailImageView.image = [UIImage imageNamed:@""];
        
    }
    else
    {
        
        
        [cell.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:location.url] placeholderImage:[UIImage imageNamed:@"noImage.jpg"] options:SDWebImageRefreshCached|SDWebImageProgressiveDownload];
        
    }
    
    return cell;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    Location *location = [_locations objectAtIndex:indexPath.row];
//
//    return 90;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_locations count];

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
