//
//  MyView.m
//  DrawTest1
//
//  Created by 玉城 辰朗 on 12/09/01.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import "MyView.h"

@implementation MyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    //線の色を設定
    [[UIColor redColor] setStroke];
    //線を描くUIBezierPathを生成
    UIBezierPath *path = [UIBezierPath bezierPath];
    //線の幅を設定
    [path setLineWidth:4];
    //始点を設定
    [path moveToPoint:CGPointMake(20,60)];
    //線を追加
    [path addLineToPoint:CGPointMake(160, 20)];
    [path addLineToPoint:CGPointMake(300, 60)];
    //線を描画
    [path stroke];
    
    //円を描画
    [[UIColor greenColor] setStroke];
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(30, 40,260,140)];
    [circle setLineWidth:5];
    [circle stroke];
    
    //塗りつぶしの長方形を描画
    [[UIColor blackColor] setStroke];
    [[UIColor redColor] setFill];
    UIBezierPath *rectangle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(60, 200, 200, 200)];
    [rectangle setLineWidth:4];
    [rectangle fill];
    [rectangle stroke];
    
}

@end
