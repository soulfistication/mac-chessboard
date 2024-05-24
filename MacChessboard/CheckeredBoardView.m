//
//  CheckeredBoardView.m
//  pattern-invert
//
//  Created by Iván Almada on 2/20/24.
//

#import "CheckeredBoardView.h"
#import "CheckeredView.h"
#import "NetworkClient.h"

#define NUM_ROWS 16
#define NUM_COLUMNS 16
#define TIME_INTERVAL 1.0
#define NUM_STIMS 180
#define IP_ADDRESS_1 @"192.168.1.196"
#define IP_ADDRESS_2 @"192.168.1.199"

@interface CheckeredBoardView ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray<CheckeredView *> *checkeredSubViews;

@property (nonatomic, strong) NetworkClient *client1;
@property (nonatomic, strong) NetworkClient *client2;

@property (nonatomic, assign) uint16_t numStims;

@end

@implementation CheckeredBoardView

#pragma mark - UIView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    NSLog(@"%@", @"initWithCoder not implemented");
    exit(0);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self buildViewHierarchy];
}

- (void)redraw {
    [self destroyViewHierarchy];
    [self buildViewHierarchy];
}

- (void)destroyViewHierarchy {
    for (NSView *checkeredView in self.checkeredSubViews) {
        [checkeredView removeFromSuperviewWithoutNeedingDisplay];
    }
    [self.checkeredSubViews removeAllObjects];
    [self.timer invalidate];
    self.timer = nil;
    self.client1 = nil;
    self.client2 = nil;
}

- (void)buildViewHierarchy {
    _numStims = NUM_STIMS;
    
    NSScreen *screen = [NSScreen mainScreen];
    
    CGFloat width = screen.frame.size.width / NUM_COLUMNS;
    CGFloat height = screen.frame.size.height / NUM_ROWS;

    CGFloat x = 0;
    CGFloat y = 0;

    self.checkeredSubViews = @[].mutableCopy;

    for (NSInteger i = 0; i < NUM_ROWS; i++) {
        for (NSInteger j = 0; j < NUM_COLUMNS; j++) {
            CheckeredView *checkeredView = [[CheckeredView alloc] initWithFrame:CGRectMake(x, y, width, height)];
            checkeredView.translatesAutoresizingMaskIntoConstraints = NO;
            checkeredView.filled = (i+j) % 2 == 0;
            [self.checkeredSubViews addObject:checkeredView];
            [self addSubview:checkeredView];
            x += width;
        }
        y += height;
        x = 0;
    }

    self.client1 = [[NetworkClient alloc] initWithIPAddress:IP_ADDRESS_1];
    self.client2 = [[NetworkClient alloc] initWithIPAddress:IP_ADDRESS_2];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:TIME_INTERVAL
                                                 repeats:YES
                                                   block:^(NSTimer * _Nonnull timer) {

        if (self.numStims == 0) {
            [self turnOffDisplay];
        }

        [self toggleCheckeredView];
        [self sendSocket];

        self.numStims--;
    }];
}

- (void)toggleCheckeredView {
    NSLog(@"%@", @"Toggle Color");
    for (CheckeredView * checkeredView in self.checkeredSubViews) {
        [checkeredView toggleColor];
    }
}

- (void)sendSocket {
    [self.client send];
}

- (void)turnOffDisplay {
    NSView *blackView = [[NSView alloc] initWithFrame:CGRectMake(0.0, 0.0, 4000.0, 4000.0)];
    blackView.layer.backgroundColor = NSColor.whiteColor.CGColor;
    blackView.layer.opacity = 1.0;
    [self.superview addSubview:blackView];
}

- (void)killApp {
    exit(0);
}

@end
