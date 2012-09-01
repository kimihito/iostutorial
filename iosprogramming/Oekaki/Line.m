//
//  Line.m
//  Oekaki
//
//  Created by 玉城 辰朗 on 12/09/01.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import "Line.h"

@implementation Line
@synthesize color,points;
@synthesize lineWidth;

-(void)dealloc{
    [color release];
    [points release];
    [super dealloc];
}
@end
