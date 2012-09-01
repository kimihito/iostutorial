//
//  DollToYenViewController.m
//  DollToYen
//
//  Created by 玉城 辰朗 on 12/09/01.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import "DollToYenViewController.h"

@interface DollToYenViewController ()

@end

@implementation DollToYenViewController
@synthesize yenLabel;
@synthesize dollText;
@synthesize rateText;

- (void)viewDidLoad
{
    [super viewDidLoad];
    dollText.delegate = self;
    rateText.delegate = self;
    
	// Do any additional setup after loading the view, typically from a nib.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}

- (void)viewDidUnload
{
    [self setDollText:nil];
    [self setRateText:nil];
    [self setYenLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [dollText release];
    [rateText release];
    [yenLabel release];
    [super dealloc];
}
- (IBAction)calc:(id)sender {
    [self.view endEditing:YES];
    double doll = [dollText.text doubleValue];
    double rate = [rateText.text doubleValue];
    double yen = doll * rate;
    yenLabel.text = [NSString stringWithFormat:@"%.2f",yen];
}
- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}
@end
