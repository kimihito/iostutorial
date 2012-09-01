//
//  DollToYenViewController.h
//  DollToYen
//
//  Created by 玉城 辰朗 on 12/09/01.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DollToYenViewController : UIViewController<UITextFieldDelegate>{
    
}
@property (retain, nonatomic) IBOutlet UITextField *dollText;

@property (retain, nonatomic) IBOutlet UITextField *rateText;
- (IBAction)calc:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *yenLabel;

- (IBAction)backgroundTapped:(id)sender;

@end
