//
//  ViewController.m
//  MacChessboard
//
//  Created by Iván Almada on 21/05/24.
//  Copyright © 2024 Iván Almada. All rights reserved.
//

#import "ViewController.h"
#import "CheckeredBoardView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet CheckeredBoardView *checkeredBoardView;

@end

@implementation ViewController

#pragma mark - NSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self setupObserver];
}

- (void)setupObserver {
    [NSNotificationCenter.defaultCenter addObserverForName:NSWindowDidEnterFullScreenNotification
                                                    object:nil
                                                     queue:[NSOperationQueue mainQueue]
                                                usingBlock:^(NSNotification * _Nonnull note) {
        [self updateView];
    }];
}

- (void)updateView {
    NSLog(@"%@", @"Changed to Fullscreen: Trigger Redraw of NSView");
    [self.checkeredBoardView redraw];
}

@end
