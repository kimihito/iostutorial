//
//  SlideShowViewController.m
//  SlideShow
//
//  Created by 玉城 辰朗 on 12/08/31.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import "SlideShowViewController.h"

@interface SlideShowViewController ()

@end

@implementation SlideShowViewController
@synthesize playButton;
@synthesize pauseButton;
@synthesize imageView;
@synthesize images;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //スライドのイメージをimage配列に格納する
    images = [[NSMutableArray alloc]initWithCapacity:6];
    for (int i = 1; i < 6;i++){
        NSString *str = [NSString stringWithFormat:@"egg-%d.png",i];
        UIImage *img = [UIImage imageNamed:str];
        [images addObject:img];
    }
    //最初のイメージ表示
    imageView.image = [images objectAtIndex:0];
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setImages:nil];
    [self setPauseButton:nil];
    [self setPlayButton:nil];
    [self setNextButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation !=UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)nextSlide:(id)sender {
    slideNumber++;
    if(slideNumber >= [images count])
    {
        slideNumber = 0;
    }
    
    //次のイメージを生成
    UIImage *image = [images objectAtIndex:slideNumber];
    UIImageView *nextView = [[UIImageView alloc]initWithImage:image];
    
    //トランジションアニメーションを実行
    [UIView transitionFromView:self.imageView toView:nextView duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft completion:NULL];
    [nextView release];
    //imageViewを更新
    self.imageView = nextView;
}



- (void)dealloc {
    [imageView release];
    [images release];
    [pauseButton release];
    [playButton release];
    [nextButton release];
    [nextButton release];
    [super dealloc];
}
- (IBAction)startShow:(id)sender {
    if(![timer isValid]){
        timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(nextSlide:) userInfo:nil repeats:YES];
    }
    
    playButton.enabled = NO;
    pauseButton.enabled = YES;
}
- (IBAction)pauseShow:(id)sender {
    if([timer isValid]){
        [timer invalidate];
    }
    timer = nil;
    playButton.enabled = YES;
    pauseButton.enabled = NO;
}
@end
