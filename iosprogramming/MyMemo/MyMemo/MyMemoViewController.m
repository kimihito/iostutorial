//
//  MyMemoViewController.m
//  MyMemo
//
//  Created by 玉城 辰朗 on 12/09/01.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import "MyMemoViewController.h"

@interface MyMemoViewController ()

@end

@implementation MyMemoViewController
@synthesize myTextView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //ファイルをロードする
    [self loadFile];
    
    }

- (void)viewDidUnload
{
    [self setMyTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [myTextView release];
    [super dealloc];
}


- (IBAction)done:(id)sender {
    //キーボードを隠す
    [self.view endEditing:YES];
    
    //テキストビューの内容にファイルをセーブする
    [self saveFile];
    
}

-(void)saveFile
{
    //保存先のパスを設定
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0]stringByAppendingPathComponent:@"memo.txt"];
    
    //テキストビューの内容を取り出す
    NSString *string = myTextView.text;
    [string writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:NULL
     ];
}

-(void)loadFile
{
    //ロードするファイルのパスを設定
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0]stringByAppendingPathComponent:@"memo.txt"];
    
    //ファイルマネージャを取得
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //ファイルが存在していればロードする
    if([fileManager fileExistsAtPath:path]){
        NSString *string = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
        
    //テキストビューに読み込んだファイルを表示
        myTextView.text = string;
    }
}
@end
