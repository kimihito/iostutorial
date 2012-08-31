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
    
    //システムサウンドIDの生成
    NSString *pathGuu = [[NSBundle mainBundle] pathForResource:@"guu" ofType:@"aif"];
    NSURL *urlGuu = [NSURL fileURLWithPath:pathGuu];
    AudioServicesCreateSystemSoundID((CFURLRef)urlGuu, &soundGuu);
    
    NSString *pathChoki = [[NSBundle mainBundle]pathForResource:@"choki" ofType:@"aif"];
    NSURL *urlChoki = [NSURL fileURLWithPath:pathChoki];
    AudioServicesCreateSystemSoundID((CFURLRef)urlChoki,&soundChoki);
    
    NSString *pathPa = [[NSBundle mainBundle] pathForResource:@"pa" ofType:@"aif"];
    NSURL *urlPa = [NSURL fileURLWithPath:pathPa];
    AudioServicesCreateSystemSoundID((CFURLRef)urlPa, &soundPa);
}

- (void)viewDidUnload
{
    [self setImages:nil];
    [self setMyImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewDidAppear:(BOOL)animated{
    [self becomeFirstResponder];
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    [self startJanken:nil];
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
    
    switch(num){
        case 0:
            AudioServicesPlaySystemSound(soundGuu);
            break;
        case 1:
            AudioServicesPlaySystemSound(soundChoki);
            break;
        case 2:
            AudioServicesPlaySystemSound(soundPa);
            break;
    }
}

- (IBAction)stopJanken:(id)sender {
    myImageView.hidden = YES;
}
@end
