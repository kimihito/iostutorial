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
}

@property (retain) NSMutableArray *images;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)nextSlide:(id)sender;

@end
