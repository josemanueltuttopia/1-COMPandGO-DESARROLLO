//
//  WebViewController.m
//  COMPandGO
//
//  Created by Jose Braña on 7/6/16.
//  Copyright © 2016 DJI. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *WebCompandgo = [NSURL URLWithString:@"http://www.google.es"];
    NSURLRequest *Request = [NSURLRequest requestWithURL:WebCompandgo];
    [_PaginaWeb loadRequest:Request];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    
    
    
    
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
