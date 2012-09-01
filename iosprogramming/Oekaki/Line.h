//
//  Line.h
//  Oekaki
//
//  Created by 玉城 辰朗 on 12/09/01.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Line : NSObject{
    UIColor *color; //色
    double lineWidth; //線幅
    NSMutableArray *points; //1つの線内の点
}

@property (retain) UIColor *color;
@property (retain) NSMutableArray *points;
@property double lineWidth;

@end
