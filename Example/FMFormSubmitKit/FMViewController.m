//
//  FMViewController.m
//  FMFormSubmitKit
//
//  Created by zhoufaming251@163.com on 04/18/2020.
//  Copyright (c) 2020 zhoufaming251@163.com. All rights reserved.
//

#import "FMViewController.h"
#import "SubmitViewController.h"

@interface FMViewController ()

@end

@implementation FMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClick:(id)sender {
    SubmitViewController *submit = [[SubmitViewController alloc] init];
    [self.navigationController pushViewController:submit animated:YES];
}

@end
