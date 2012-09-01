//
//  CanvasView.m
//  Oekaki
//
//  Created by 玉城 辰朗 on 12/09/01.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import "CanvasView.h"
#import "Line.h"

@implementation CanvasView


- (void)drawRect:(CGRect)rect
{
    //lines配列から一つの線を取り出す
    for(Line *line in lines){
        //色を指定
        [line.color set];
        //一本の線を描く
        UIBezierPath* path = [UIBezierPath bezierPath];
        [path setLineWidth:line.lineWidth]; //線幅
        BOOL first = YES;
        for(NSValue *value in line.points){
            if(first){
                //初期位置に移動
                [path moveToPoint:[value CGPointValue]];
                first = NO;
            }
            //次のポイントに移動
            [path addLineToPoint:[value CGPointValue]];
        }
        [path stroke]; //線を描画
    }
}

-(void)dealloc{
    [lines release];
    [super dealloc];
}
@end
