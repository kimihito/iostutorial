//
//  MyMemoViewController.h
//  MyMemo
//
//  Created by 玉城 辰朗 on 12/09/01.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMemoViewController : UIViewController{
    UITextView *myTextView;
}
@property (retain, nonatomic) IBOutlet UITextView *myTextView;
- (IBAction)done:(id)sender;

-(void)saveFile;
-(void)loadFile;
@end
