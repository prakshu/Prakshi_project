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
//#import "UIImageView+WebCache.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    if ([[UIDevice currentDevice] userInterfaceIdiom] ==
        UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 736)//6 plus and 6s plus
    {
        self.tableView.frame=CGRectMake(0, 0, 414, 736);

    }
    else if ([[UIDevice currentDevice] userInterfaceIdiom] ==
             UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568)//5s
    {
        self.tableView.frame=CGRectMake(0, 0, 320, 568);
    }
    else if ([[UIDevice currentDevice] userInterfaceIdiom] ==
        UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 1104)//7 plus
    {
        self.tableView.frame=CGRectMake(0, 0, 621, 1104);
    }
    else if ([[UIDevice currentDevice] userInterfaceIdiom] ==
        UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 667)//iph 6
    {
        self.tableView.frame=CGRectMake(0, 0, 375, 667);
    }
   else if ([[UIDevice currentDevice] userInterfaceIdiom] ==
        UIUserInterfaceIdiomPad && [UIScreen mainScreen].bounds.size.height == 1366)//ipad 12.9
    {
        self.tableView.frame=CGRectMake(0, 0, 1024, 1366);
    }
   
   else if ([[UIDevice currentDevice] userInterfaceIdiom] ==
            UIUserInterfaceIdiomPad && [UIScreen mainScreen].bounds.size.height == 1024)//ipad 9.
   {
       self.tableView.frame=CGRectMake(0, 0, 768, 1024);
   }
   else if ([[UIDevice currentDevice] userInterfaceIdiom] ==
            UIUserInterfaceIdiomPad && [UIScreen mainScreen].bounds.size.height == 1112)//ipad 10.5
   {
       self.tableView.frame=CGRectMake(0, 0, 834, 1112);
   }
   
   else if ([[UIDevice currentDevice] userInterfaceIdiom] ==
            UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 812)//iph x
    {
        self.tableView.frame=CGRectMake(0, 0, 375, 812);

    }

   
    
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
    static NSString *simpleTableIdentifier = @"testCell";

    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];

    }
    Location *location = [_locations objectAtIndex:indexPath.row];

    UIImageView *ImageView = (UIImageView *)[cell viewWithTag:100];

    UILabel *titleLabel = (UILabel *)[cell viewWithTag:101];
    
    UILabel *descLabel = (UILabel *)[cell viewWithTag:102];
    
    
    id displayNameTypeValue = location.Descriptrion;
    id nameType = location.Title;
    id imgType = location.url;
    
    if ( displayNameTypeValue == [NSNull null])
    {
        descLabel.text = @"";
        
    }
    else
    {
        NSInteger myLength = [location.Descriptrion length];
      descLabel.text = location.Descriptrion;
        if(location.Descriptrion.length>172)
        {
           descLabel.text = location.Descriptrion;
            self.tableView.rowHeight=200;
        }
        else{
            self.tableView.rowHeight=116;

        }
        
//        NSLog( @"lenghth is %d",myLength );
    }
    if ( nameType == [NSNull null])
    {
      titleLabel.text = @"";
        
    }
    else
    {
        titleLabel.text = location.Title;
        
    }
    if ( imgType == [NSNull null])
    {
      ImageView.image = [UIImage imageNamed:@""];
        
    }
    else
    {
        
      [ImageView sd_setImageWithURL:[NSURL URLWithString:location.url] placeholderImage:[UIImage imageNamed:@"noImage.jpg"] options:SDWebImageRefreshCached|SDWebImageProgressiveDownload];
        
    }
    
    return cell;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{

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
