//
//  ViewController.m
//  msse652
//
//  Created by Phuong Nguyen on 3/21/15.
//  Copyright (c) 2015 msse. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *CourseTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *CourseImageView;
@property (weak, nonatomic) IBOutlet UILabel *JunkLabel;

@end
@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
/*    self.CourseTitleLabel.text = [self.CourseDetail objectForKey:@"name"];
    
    [self.CourseImageView setImageWithURL:[NSURL URLWithString:[self.CourseDetail objectForKey:@"icon"]]];
    
    self.JunkLabel.text = [self.CourseDetail objectForKey:@"formatted_address"];
*/

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
