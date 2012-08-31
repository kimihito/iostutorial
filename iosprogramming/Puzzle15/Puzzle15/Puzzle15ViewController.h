//
//  Puzzle15ViewController.h
//  Puzzle15
//
//  Created by 玉城 辰朗 on 12/08/30.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Puzzle15ViewController : UIViewController{
    NSArray *pieces;
    int empty;
}
@property (retain, nonatomic) IBOutletCollection(PieceView) NSArray *pieces;
- (IBAction)shufflePiece:(id)sender;

@end
