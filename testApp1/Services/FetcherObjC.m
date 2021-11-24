//
//  FetcherObjC.m
//  testApp1
//
//  Created by Sergey Ivanov on 22.11.2021.
//
#import "FetcherObjC.h"
#import <Foundation/Foundation.h>


@implementation FetcherObjC

- (instancetype) init {
    self = [super init];
    if (self) {
        imagePath = @"https://random-d.uk/api/random?format=json";
        textPath = @"https://api.forismatic.com/api/1.0/?method=getQuote&format=json";
    }
    return self;
}


- (NSArray<ImageAndText *> * _Nullable)fetchFromStorage {
    return [_storer load];
}

- (void)cancelAllRequests { 
    [NSURLSession.sharedSession invalidateAndCancel];
    NSLog(@"func invalidateAndCancel() executed");
}

- (void)deleteRecord:(ImageAndText * _Nonnull)item { 
    [_storer deleteRecordWithItem:item]; 
}



- (void)fetchFromWebWithItemsAmount:(NSInteger)itemsAmount { 
    // clean store
    [_storer deleteAllRecords];
    // fetch from web and one by one pass to the delegate
    NSURL * imageJsonUrl = [[NSURL alloc] initWithString:imagePath];
    NSURL * textUrl = [[NSURL alloc] initWithString:textPath];
    
    dispatch_queue_global_t globalQueue = dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0);
    dispatch_async(globalQueue, ^{
        
       __weak typeof(self) weakSelf = self;
        
        int requestIndex;
        for (requestIndex = 0; requestIndex < itemsAmount; requestIndex++) {
            
            [weakSelf.webRequester fetchImageDataWithUrl:imageJsonUrl closure:^(NSData * _Nullable data) {
                
                if (data) {
                    UIImage * image = [[UIImage alloc] initWithData:data];
                    
                    NSString * text = [weakSelf.webRequester fetchTextWithUrl:textUrl];
                    
                    ImageAndText * item = [[ImageAndText alloc] initWithDbid:nil image:image text:text];
                    
                    ImageAndText * itemWithID = [weakSelf.storer saveWithItem:item];
                    if (itemWithID) {
                        item = itemWithID;
                    }
                    
                    [weakSelf.delegate handlingFetchedResultsWithAsyncReceivedItem:item atIndex:requestIndex];

                }
            }];
        }
        
    });

}


@end
