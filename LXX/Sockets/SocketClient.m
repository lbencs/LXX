////
////  SocketClient.m
////  DomeUI
////
////  Created by lben on 2019/4/11.
////  Copyright © 2019 lben. All rights reserved.
////
//
//#import "SocketClient.h"
//#import <CocoaAsyncSocket/GCDAsyncUdpSocket.h>
//
//@interface SocketClient ()<GCDAsyncUdpSocketDelegate>
//@property (nonatomic, strong) GCDAsyncUdpSocket *socket;
//@property (nonatomic, strong) dispatch_queue_t delegateQueue;
//@property (nonatomic, strong) dispatch_queue_t socketQueue;
//@end
//
//@implementation SocketClient
//
//+ (instancetype)share {
//    static dispatch_once_t onceToken;
//    static SocketClient *_client;
//    dispatch_once(&onceToken, ^{
//        _client = [[SocketClient alloc] init];
//    });
//    
//    return _client;
//}
//
//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        _socket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:self.delegateQueue socketQueue:self.socketQueue];
//    }
//    return self;
//}
//
//- (void)test {
//    uint16_t port = 8888;
//    NSError *error;
//    [self.socket connectToHost:@"127.0.0.1" onPort:port error: &error];
//    
//    NSData *sendData = [@"鲁文涛❤️孙榕蔓" dataUsingEncoding: NSUTF8StringEncoding];
////    [self.socket sendData: sendData  withTimeout:1 tag:1];
////    [self.socket sendData:sendData toHost:@"127.0.0.1" port:port withTimeout:3 tag:2];
//}
//
//#pragma mark -
//
//#pragma mark - getter/setter
//
//- (dispatch_queue_t)delegateQueue {
//    if (!_delegateQueue) {
//        _delegateQueue = dispatch_queue_create("com.lben.socket.udp.delegate.queue", DISPATCH_QUEUE_CONCURRENT);
//    }
//    
//    return _delegateQueue;
//}
//
//- (dispatch_queue_t)socketQueue {
//    if (!_socketQueue) {
//        _socketQueue = dispatch_queue_create("com.lben.socket.udp.socket.queue", DISPATCH_QUEUE_CONCURRENT);
//    }
//    
//    return _socketQueue;
//}
//
//@end
