//
//  ViewControllerObjC.m
//  testApp1
//
//  Created by Sergey Ivanov on 10.11.2021.
//

#import <Foundation/Foundation.h>
#import "ViewControllerObjC.h"
#import "DataStorerObjC.h"
#import "FetcherObjC.h"
#import "WebRequesterObjC.h"

@implementation ViewControllerObjC



-(IBAction)loadFromWebButton:(id)sender {
    NSLog(@"loadFromWebButton button pressed ->");
    [fetcher fetchFromWebWithItemsAmount:rowsCount];
    
}



-(void) viewDidLoad {
    [super viewDidLoad];
    rowsCount = 3;
    images = [self arrayWithImageStubs:rowsCount];
    fetcher = [[FetcherObjC alloc] init];
    fetcher.webRequester = [[WebRequesterObjC alloc] init];
    fetcher.storer = [[DataStorerObjC alloc] init];
    fetcher.delegate = (id)self ;
    
    
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // first load images from db
    NSArray<ImageAndText *> * imagesAndTexts = [fetcher fetchFromStorage];
    dispatch_queue_main_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        self->images = imagesAndTexts.mutableCopy;
        [self->_tableView reloadData];
    });
    
    
}

-(void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [fetcher cancelAllRequests];
}

-(NSMutableArray<ImageAndText*> *) arrayWithImageStubs: (int) itemsAmount {
    UIImage * image = [UIImage systemImageNamed: @"hourglass"];
    NSMutableArray<ImageAndText*> * array = [[NSMutableArray alloc] init];
    int i;
    for (i = 0; i < itemsAmount; i++ ) {
        ImageAndText * imageAndText = [[ImageAndText alloc] initWithDbid:nil image:image text:nil];
        [array addObject: imageAndText];
    }
    NSLog(@"array of stubs have %li elements", (long)array.count );
    return array ;
    
    
}




@end
