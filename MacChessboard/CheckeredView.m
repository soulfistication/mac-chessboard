//
//  CheckeredView.m
//  pattern-invert
//
//  Created by Iván Almada on 2/20/24.
//

#import "CheckeredView.h"

@implementation CheckeredView

#pragma mark - UIView

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    NSLog(@"%@", @"initWithCoder not implemented");
    exit(0);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        self.layer.backgroundColor = NSColor.whiteColor.CGColor;
    }

    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

#pragma mark - Helpers

- (void)toggleColor {
    self.isFilled ? (self.layer.backgroundColor = NSColor.whiteColor.CGColor) : (self.layer.backgroundColor = NSColor.blackColor.CGColor);
    self.filled = !self.isFilled;
}

@end
