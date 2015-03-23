//
//  TableTableViewController.m
//  msse652
//
//  Created by Phuong Nguyen on 3/21/15.
//  Copyright (c) 2015 msse. All rights reserved.
//

#import "TableTableViewController.h"
#import "ViewController.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"

@interface TableTableViewController ()

@property (strong, nonatomic) NSArray *ScisProgramArray;
@property (strong, nonatomic) NSArray *finishedScisProgramArray;

@end

@implementation TableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self InfoRequests];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//----------------------------------------------------------------------------------------------
// Get the data from website
//----------------------------------------------------------------------------------------------

-(void)InfoRequests
{
    NSURL *url = [NSURL URLWithString:@"http://regisscis.net/fRegis2/webresources/regis2.program"];
    
    
//    http://www.regis.edu/CPS/Schools/School-of-Computer-and-Information-Sciences.aspx
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //AFNetworking asynchronous url request
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
 //  AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
   
 //   manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/rss+xml"];
 
    //application/rss+xml
//manager.responseSerializer = [AFXMLResponseSerializer new];
    
   operation.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
      
        self.ScisProgramArray = [responseObject objectForKey:@"results"];
        NSLog(@"The Array: %@",self.ScisProgramArray);
        
        [self.tableView reloadData];
        
    }
    
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Request Failed: %@, %@", error, error.userInfo);
        
    }];
    
    [operation start];
    
}

#pragma mark - Table view data source
//----------------------------------------------------------------------------------------------
// TableView
//----------------------------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.ScisProgramArray count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    
//--------------------------------------------------------------------------------------------
// Configure the cell...
//--------------------------------------------------------------------------------------------
    NSDictionary *tempDictionary= [self.ScisProgramArray objectAtIndex:indexPath.row];
    
    
    
    cell.textLabel.text = [tempDictionary objectForKey:@"name"];
    
    
    
    if([tempDictionary objectForKey:@"rating"] != NULL)
        
    {
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Rating: %@ of 5",[tempDictionary   objectForKey:@"rating"]];
        
    }
    
    else
        
    {
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Not Rated"];
        
    }
    return cell;
}

#pragma mark - Prepare For Segue
//----------------------------------------------------------------------------------------------
// Segue
//----------------------------------------------------------------------------------------------

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender

{
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    ViewController *detailViewController = (ViewController *)segue.destinationViewController;
    
    detailViewController.CourseDetail = [self.ScisProgramArray objectAtIndex:indexPath.row];
    
}


@end
