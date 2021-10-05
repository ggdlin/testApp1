//
//  ObjCDataStorer.m
//  testApp1
//
//  Created by Sergey Ivanov on 24.09.2021.
//
//
#import "ObjCDataStorer.h"
#import "testApp1-Swift.h"

@interface ObjCDataStorer()
@property (nonatomic, strong) DataStorer *dataStorer;
@end

@implementation ObjCDataStorer;
- (id) init {
    self = [super init];
    
    if (self) {
        self.dataStorer = [DataStorer new];
    }
    return self;
}


- (int) load {
    printf("load form ObjCDataStorer\n");
    // TODO: add swift class instance and call any function
    
    NSArray<ImageAndText*> *result = [self.dataStorer load];
    NSLog(@"Result count: %lu", (unsigned long)result.count);
    return (int)result.count;
}


@end

