//
//  ViewController.m
//  NSOperationQueueDemo
//
//  Created by LayZhang on 2015/5/2.
//  Copyright © 2015年 Zhanglei. All rights reserved.
//

#import "ViewController.h"
#import "ZLOperation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self operationTest];
}

- (void)operationTest {
    // operation invo
    NSInvocationOperation * invo1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(testOperation) object:nil];
    
    NSInvocationOperation * invo2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(testOperation) object:nil];
    // 添加依赖
    [invo1 addDependency:invo2];
    
    ZLOperation *operation = [[ZLOperation alloc] init];
    
    
    // operationblock
    NSBlockOperation * blockOperation = [NSBlockOperation
                                         blockOperationWithBlock:^{
                                             NSLog(@"1在第%@个线程",[NSThread currentThread]);
                                         }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"2在第%@个线程",[NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"3在第%@个线程",[NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"4在第%@个线程",[NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"5在第%@个线程",[NSThread currentThread]);
    }];

    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [queue addOperation:invo1];
//    [queue addOperation:invo2];
//    [queue addOperation:blockOperation];
    [queue addOperation:operation];
}

- (void)testOperation {
    NSLog(@"我在第%@个线程",[NSThread currentThread]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
