//
//  DetailViewController.h
//  SCISPrograms
//
//  Created by Phuong Nguyen on 3/17/15.
//  Copyright (c) 2015 msse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (copy, nonatomic) NSString *url;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

