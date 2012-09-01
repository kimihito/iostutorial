//
//  MyView.m
//  GStamp
//
//  Created by 玉城 辰朗 on 12/09/01.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import "MyView.h"

@implementation MyView
@synthesize points;
@synthesize myImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        points = [[NSMutableArray alloc]init]; //配列pointsを初期化
        self.backgroundColor = [UIColor yellowColor]; //背景を黄色に
        myImage = [UIImage imageNamed:@"pa.png"];
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //タッチ位置を取得
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    //配列pointsに追加
    [points addObject:[NSValue valueWithCGPoint:location]];
    
    //再描画
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{
   //イメージをpointsの位置に描画する
    for (NSValue *value in points){
        CGPoint point = [value CGPointValue];
        [myImage drawAtPoint:CGPointMake(point.x - myImage.size.width / 2, point.y - myImage.size.height /2)];
    }
}


@end
