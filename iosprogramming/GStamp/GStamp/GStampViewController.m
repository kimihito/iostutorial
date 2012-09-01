//
//  GStampViewController.m
//  GStamp
//
//  Created by 玉城 辰朗 on 12/09/01.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import "GStampViewController.h"
#import "MyView.h"

@interface GStampViewController ()

@end

@implementation GStampViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    MyView *myView = [[MyView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:myView];
    [myView release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
