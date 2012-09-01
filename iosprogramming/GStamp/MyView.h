//
//  MyView.h
//  GStamp
//
//  Created by 玉城 辰朗 on 12/09/01.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyView : UIView{
    NSMutableArray *points; //タッチする位置を管理する配列
    UIImage *myImage; //表示するイメージ
}
@property (retain) NSMutableArray *points;
@property (retain) UIImage *myImage;
@end
