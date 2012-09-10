//
//  RecordViewController.m
//  RecordApp
//
//  Created by 玉城 辰朗 on 12/09/07.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import "RecordViewController.h"

@interface RecordViewController ()

@end

@implementation RecordViewController
@synthesize textField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    textField.text = @"Press Rec Button";
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [textField release];
    [super dealloc];
}
- (IBAction)recButton:(id)sender {
        
}
@end
