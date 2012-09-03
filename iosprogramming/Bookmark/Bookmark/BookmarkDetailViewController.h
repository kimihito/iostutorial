//
//  BookmarkDetailViewController.h
//  Bookmark
//
//  Created by 玉城 辰朗 on 12/09/02.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookmarkDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
