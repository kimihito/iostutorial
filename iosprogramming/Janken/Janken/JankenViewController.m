//
//  JankenViewController.m
//  Janken
//
//  Created by 玉城 辰朗 on 12/08/30.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import "JankenViewController.h"

@interface JankenViewController ()

@end

@implementation JankenViewController
@synthesize myImageView;
@synthesize images;

- (void)viewDidLoad
{
    [super viewDidLoad];
    srand(time(NULL));
    images = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"guu"],[UIImage imageNamed:@"choki"],
              [UIImage imageNamed:@"pa"],nil];

}

- (void)viewDidUnload
{
    [self setImages:nil];
    [self setMyImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [myImageView release];
    [super dealloc];
}
- (IBAction)startJanken:(id)sender {
    myImageView.hidden = NO;
    int num = rand() % 3;
    myImageView.image = [images objectAtIndex:num];
}

- (IBAction)stopJanken:(id)sender {
    myImageView.hidden = YES;
}
@end
