//
//  JankenViewController.h
//  Janken
//
//  Created by 玉城 辰朗 on 12/08/30.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>

@interface JankenViewController : UIViewController{
    UIImageView *myImageView;
    NSArray *images;
    
    SystemSoundID soundChoki;
    SystemSoundID soundGuu;
    SystemSoundID soundPa;
}
@property(retain)NSArray *images;
@property (retain, nonatomic) IBOutlet UIImageView *myImageView;
- (IBAction)startJanken:(id)sender;

- (IBAction)stopJanken:(id)sender;
@end
