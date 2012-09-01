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


+(void)initialize{
    //キーと初期値のペアの辞書を生成
    NSMutableDictionary *defaultValues = [NSMutableDictionary dictionaryWithCapacity:2];
    //ドルの初期値を10に
    [defaultValues setValue:@"10" forKey:kDoll];
    //レートの初期値を84.5に
    [defaultValues setValue:@"84.5" forKey:kRate];
    
    NSUserDefaults *userDefaults =  [NSUserDefaults standardUserDefaults];
    //初期値を設定
    [userDefaults registerDefaults:defaultValues];  
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    dollText.delegate = self;
    rateText.delegate = self;
    
    //ユーザーデフォルトの読み込み
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *dollStr = [userDefaults stringForKey:kDoll];
    NSString *rateStr = [userDefaults stringForKey:kRate];
    dollText.text = dollStr;
    rateText.text = rateStr;
    
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
    
    //ユーザーデフォルトを保存
    [self saveDefault];
}
- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}

-(void)saveDefault
{
    //ドルとレートをユーザーデフォルトに保存
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dollText.text forKey:kDoll];
    [userDefaults setObject:rateText.text forKey:kRate];
    [userDefaults synchronize];
}

@end
