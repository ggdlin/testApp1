//
//  ViewControllerObjC+ViewControllerObjC_FetcherDelegate.m
//  testApp1
//
//  Created by Sergey Ivanov on 15.11.2021.
//

#import "ViewControllerObjC+ViewControllerObjC_FetcherDelegate.h"

@implementation ViewControllerObjC (ViewControllerObjC_FetcherDelegate)

- (void)handlingFetchedResultsWithAsyncReceivedItem:(ImageAndText * _Nonnull)asyncReceivedItem atIndex:(NSInteger)atIndex {
    
    dispatch_queue_main_t mainQueue =  dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        if (self) {
            if ([self->images count] != self->rowsCount ) {
                self->images = [self arrayWithImageStubs:(self->rowsCount)];
                [self.tableView reloadData];
            }
            self->images[atIndex] = asyncReceivedItem;
            NSIndexPath  *indexPath = [NSIndexPath indexPathForRow:atIndex inSection:0];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:100];
        }
        
    });
    
    
    
}

@end
