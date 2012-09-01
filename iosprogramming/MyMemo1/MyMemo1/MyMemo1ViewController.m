//
//  MyMemo1ViewController.m
//  MyMemo1
//
//  Created by 玉城 辰朗 on 12/09/01.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import "MyMemo1ViewController.h"

@interface MyMemo1ViewController ()

@end

@implementation MyMemo1ViewController
@synthesize myTextView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	//ファイルをロードする
    [self loadFile];
    
    //システム標準の通知センターを取得
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    //キーボードが表示されたらkeyboardDidShow:メソッドを実行
    [notificationCenter addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    //キーボードが隠れたらkeyboardDidHide:メソッドを実行
    [notificationCenter addObserver:self selector:@selector(keyboardDidHide:)name:UIKeyboardDidHideNotification object:nil];
}

-(void)keyboardDidShow:(NSNotification *)notification
{
    //通知情報を取り出す
    NSDictionary* info = [notification userInfo];
    //キーボードのサイズを取得する
    NSValue* aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect kbFrame = [aValue CGRectValue];
    
    //テキストビューの高さをキーボードのサイズ分縮小する
    CGRect textFrame = myTextView.frame;
    textFrame.size.height -= kbFrame.size.height;
    myTextView.frame = textFrame;
}

//キーボードが隠れたらテキストビューの高さを戻す
-(void)keyboardDidHide:(NSNotification *)notification
{
    //通知情報を取り出す
    NSDictionary* info = [notification userInfo];
    //キーボードのサイズを取得する
    NSValue* aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect kbFrame = [aValue CGRectValue];
    
    //テキストビューの高さをもとに戻す
    CGRect textFrame = myTextView.frame;
    textFrame.size.height += kbFrame.size.height;
    myTextView.frame = textFrame;
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
    //テキストビューの内容をファイルにセーブする
    [self saveFile];
}

-(void)saveFile
{
    //保存先のパスを設定
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0]stringByAppendingPathComponent:@"memo.txt"];
    
    //テキストビューの内容を取り出す
    NSString *string = myTextView.text;
    //ファイルに保存する
    [string writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:NULL];
}

-(void)loadFile
{
    //ロードするファイルのパスを設定
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
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
