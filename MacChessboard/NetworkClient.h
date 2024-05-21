//
//  NetworkClient.h
//  pattern-invert
//
//  Created by Iván Almada on 2/28/24.
//

#import <Foundation/Foundation.h>

@import CocoaAsyncSocket;

NS_ASSUME_NONNULL_BEGIN

@interface NetworkClient : NSObject<GCDAsyncSocketDelegate>

- (instancetype)initWithIPAddress:(NSString *)address;
- (void)send;
- (void)disconnect;

@end

NS_ASSUME_NONNULL_END
