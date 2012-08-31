//
//  SlideShowViewController.h
//  SlideShow
//
//  Created by 玉城 辰朗 on 12/08/31.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideShowViewController : UIViewController{
    NSMutableArray *images;
    int slideNumber;
    
    UIImageView *imageView;
    UIToolbar *nextButton;
    
    NSTimer *timer;
}



@property (retain) NSMutableArray *images;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@property (retain, nonatomic) IBOutlet UIBarButtonItem *nextButton;

- (IBAction)nextSlide:(id)sender;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *playButton;
- (IBAction)startShow:(id)sender;

@property (retain, nonatomic) IBOutlet UIBarButtonItem *pauseButton;
- (IBAction)pauseShow:(id)sender;

@end
