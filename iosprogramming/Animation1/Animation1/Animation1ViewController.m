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
    imageView.animationDuration = 0.6;
    [imageView startAnimating];
    //タイマーを開始
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(move:) userInfo:nil repeats:YES];
}

-(void)move:(NSTimer *)timer
{
    //進行方向に示すスタティック変数
    static int direction = 1;
    int parentWidth = self.view.frame.size.width;
    
    CGRect frame = imageView.frame;
    int x = frame.origin.x;
    
    //端まで行ったら方向を反転させる
    if((x > (parentWidth - frame.size.width) ) ||(x < 0)) {
        direction = direction * -1;
    }
    frame.origin.x = x + direction * 2;
    imageView.frame = frame;
    
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
