//
//  Puzzle15ViewController.m
//  Puzzle15
//
//  Created by 玉城 辰朗 on 12/08/30.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import "Puzzle15ViewController.h"
#import "PieceView.h"

enum{
    kLeft = 1,
    kRight = 2,
    kUp = 3,
    kDown = 4,
};

const int kSize = 70;

@interface Puzzle15ViewController ()

@end

@implementation Puzzle15ViewController
@synthesize pieces;


- (void)viewDidLoad
{
    [super viewDidLoad];
    srand(time(NULL));
    empty = 15;
    for (PieceView *piece in pieces){
        piece.location = piece.tag;
        piece.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [piece addGestureRecognizer:tapper];
        [tapper release];
        
        UIPanGestureRecognizer *pangr = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [piece addGestureRecognizer:pangr];
        [pangr release];
    }
   

}

-(void)tap:(UITapGestureRecognizer *)gesture
{
    [self movePiece:(PieceView *)gesture.view];
}

-(void)movePiece:(PieceView *)aPiece
{
    if([self isMovable:aPiece.location]){
        CGRect newFrame = aPiece.frame;
        newFrame.origin.x = kSize * (empty % 4);
        newFrame.origin.y = kSize * (empty / 4);
        aPiece.frame = newFrame;
        
        int oldempty = empty;
        empty = aPiece.location;
        aPiece.location = oldempty;
    }
}

-(int)isMovable:(int)tapPos
{
    int result = 0;
    if(tapPos == (empty - 4)){
        result = kDown;
    }else if(tapPos ==(empty +4)){
        result = kUp;
    }else if(((tapPos % 4)!=0) &&((tapPos - 1) == empty)){
        result = kLeft;
    }else if(((tapPos % 4) != 3) && ((tapPos + 1) == empty)){
        result = kRight;
    }
    return result;
}


-(void)pan:(UIPanGestureRecognizer *)gesture
{
    PieceView *aPiece = (PieceView *)gesture.view;
    int direction = [self isMovable:aPiece.location];
    if (direction) {
        if((gesture.state == UIGestureRecognizerStateChanged)||(gesture.state == UIGestureRecognizerStateEnded)){
            CGPoint translation = [gesture translationInView:aPiece];
            if ((direction == kLeft) && (translation.x < 0)) {
                panning = YES;
                aPiece.center = CGPointMake(aPiece.center.x +translation.x, aPiece.center.y);
            }else if((direction == kRight) &&(translation.x > 0)){
                panning = YES;
                aPiece.center = CGPointMake(aPiece.center.x+translation.x,aPiece.center.y);
            }else if((direction == kUp) && (translation.y < 0)){
                panning = YES;
                aPiece.center = CGPointMake(aPiece.center.x, aPiece.center.y + translation.y);
            }else if((direction == kDown) && (translation.y > 0)){
                panning = YES;
                aPiece.center = CGPointMake(aPiece.center.x, aPiece.center.y+translation.y);
            }
            [gesture setTranslation:CGPointZero inView:aPiece];
        }
        
        if(gesture.state == UIGestureRecognizerStateEnded){
            if(panning)[self movePiece:aPiece];
            panning = NO;
        }
    }
}

- (void)viewDidUnload
{


    [self setPieces:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {

    [pieces release];
    [super dealloc];
}
- (IBAction)shufflePieces:(id)sender {
    for(int i = 0; i < 100; i++){
        [self movePiece:[pieces objectAtIndex:rand() % pieces.count]];
    }
}
@end
