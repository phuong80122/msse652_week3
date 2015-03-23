//
//  MasterViewController.m
//  SCISPrograms
//
//  Created by Phuong Nguyen on 3/17/15.
//  Copyright (c) 2015 msse. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "AFNetworking.h"



@interface MasterViewController ()

{
NSXMLParser *parser;
NSMutableArray *feeds;
NSMutableDictionary *program;
NSMutableString *name;
NSMutableString *link;
NSString *element;
}
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}


//------------------------------------------------------------------------------------------------------
// Loading SCIS Programs using AFNetworking and NSXMLParser
//------------------------------------------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

     feeds = [[NSMutableArray alloc] init];

 NSURL *url = [NSURL URLWithString:@"http://regisscis.net/Regis2/webresources/regis2.program"];
 NSURLRequest *request = [NSURLRequest requestWithURL:url];
 
 AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
 
 // Make sure to set the responseSerializer correctly
 operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
 
 [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
 
 NSXMLParser *XMLParser = (NSXMLParser *)responseObject;
 [XMLParser setShouldProcessNamespaces:YES];
 
 XMLParser.delegate = self;
 [XMLParser parse];
 
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 
 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Data"
 message:[error localizedDescription]
 delegate:nil
 cancelButtonTitle:@"Ok"
 otherButtonTitles:nil];
 [alertView show];
 
 }];
 
 [operation start];
 

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:@"program"]) {
        
        program    = [[NSMutableDictionary alloc] init];
        name   = [[NSMutableString alloc] init];
        link    = [[NSMutableString alloc] init];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"program"]) {
        
        [program setObject:name forKey:@"name"];
        [program setObject:link forKey:@"link"];
        
        [feeds addObject:[program copy]];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"name"]) {
        [name appendString:string];
    } else if ([element isEqualToString:@"link"]) {
        [link appendString:string];
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.tableView reloadData];
    
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *string = [feeds[indexPath.row] objectForKey: @"link"];
        [[segue destinationViewController] setUrl:string];
        
    }
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey: @"name"];
    return cell;
}
@end
