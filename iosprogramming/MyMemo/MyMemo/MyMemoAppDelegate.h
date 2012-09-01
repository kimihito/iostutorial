//
//  MyMemoAppDelegate.h
//  MyMemo
//
//  Created by 玉城 辰朗 on 12/09/01.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyMemoViewController;

@interface MyMemoAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) IBOutlet MyMemoViewController *viewController;
@end
