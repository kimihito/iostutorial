//
//  OekakiViewController.h
//  Oekaki
//
//  Created by 玉城 辰朗 on 12/09/01.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Line.h"


@interface OekakiViewController : UIViewController{
    //線を管理する配列
    NSMutableArray *lines;
    //1本の線
    Line *line;
    //線色
    UIColor *lineColor;
    //線の幅
    float lineWidth;
    
    UISegmentedControl *colorSegmentControl;
    
}
@property (retain, nonatomic) IBOutlet UISegmentedControl *colorSegmentControl;
- (IBAction)undo:(id)sender;
- (IBAction)clearImage:(id)sender;

- (IBAction)saveToPhotoAlbum:(id)sender;
- (IBAction)changeColor:(id)sender;

@property (retain)NSMutableArray *lines;
@property (retain)UIColor *lineColor;

@end
