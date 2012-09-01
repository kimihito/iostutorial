//
//  OekakiViewController.m
//  Oekaki
//
//  Created by 玉城 辰朗 on 12/09/01.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import "OekakiViewController.h"
#import "CanvasView.h"
#import "Line.h"


@interface OekakiViewController ()

@end

@implementation OekakiViewController
@synthesize colorSegmentControl;


- (void)viewDidLoad
{
    [super viewDidLoad];
    //線を格納する配列を生成
    lines = [[NSMutableArray alloc]init];
    
    //背景色を白に設定
    self.view.backgroundColor = [UIColor whiteColor];
    //デフォルトの線の色を黒に
    lineColor = [UIColor blackColor];
    //線幅を5に設定
    lineWidth = 5.0;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    ((CanvasView *)(self.view)).lines = self.lines;
    
    //ひとつの線を格納するオブジェクトを生成
    line = [[Line alloc]init];
    line.color = lineColor;
    line.lineWidth = lineWidth;
    line.points = [[NSMutableArray alloc]init];
    //線を配列linesに格納
    [lines addObject:line];
    [line release];
    
    //現在のポイントを軌跡に追加
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    [line.points addObject:[NSValue valueWithCGPoint:point]];
    
    //viewを書き換える
    [self.view setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //現在のポイントを線に追加
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    [line.points addObject:[NSValue valueWithCGPoint:point]];
    
    //viewを書き換える
    [self.view setNeedsDisplay];
}

- (void)viewDidUnload
{
    [self setColorSegmentControl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [colorSegmentControl release];
    [super dealloc];
}
- (IBAction)undo:(id)sender {
    if([lines count]){
        [lines removeLastObject];
        [self.view setNeedsDisplay];
    }
}

- (IBAction)clearImage:(id)sender {
    [lines removeAllObjects];
    [self.view setNeedsDisplay];
}

- (IBAction)saveToPhotoAlbum:(id)sender {
}

- (IBAction)changeColor:(id)sender {
    switch (colorSegmentControl.selectedSegmentIndex) {
        case 0:
            lineColor = [UIColor blackColor];
            break;
        case 1:
            lineColor = [UIColor redColor];
            break;
        case 2:
            lineColor = [UIColor greenColor];
            break;
        case 3:
            lineColor = [UIColor yellowColor];
            break;
        default:
            break;
    }
}
@end
