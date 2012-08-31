//
//  Animation1ViewController.m
//  Animation1
//
//  Created by 玉城 辰朗 on 12/08/31.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import "Animation1ViewController.h"

@interface Animation1ViewController ()

@end

@implementation Animation1ViewController
@synthesize imageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSArray *imageArray = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"egg01.png"],[UIImage imageNamed:@"egg02.png"],[UIImage imageNamed:@"egg03.png"],[UIImage imageNamed:@"egg04.png"],[UIImage imageNamed:@"egg05.png"], nil];
    
    imageView.animationImages = imageArray;
    [imageArray release];
    imageView.animationDuration = 0.5;
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [imageView release];
    [super dealloc];
}
- (IBAction)startAction:(id)sender {
    if(![imageView isAnimating]){
        [imageView startAnimating];     
    }
    
}

- (IBAction)stopAction:(id)sender {
    if([imageView isAnimating]){
        [imageView stopAnimating];
    }
}
@end
