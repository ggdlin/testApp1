//
//  DataStorerObjC.m
//  testApp1
//
//  Created by Sergey Ivanov on 18.11.2021.
//

#import <Foundation/Foundation.h>
#import "DataStorerObjC.h"

@implementation DataStorerObjC

-(instancetype) init {
    self = [super init];
    if (self) {
        id delegate = UIApplication.sharedApplication.delegate;
        if (delegate != nil) {
            AppDelegate * appdelegate = delegate;
            _context = appdelegate.persistentContainer.viewContext;
        } else {
            _context = [[NSManagedObjectContext alloc] initWithCoder:[NSCoder new]];
        }
        
    }
    return self;
}


- (void)deleteAllRecords { 
    NSFetchRequest<Record *> * fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Record"];
    NSBatchDeleteRequest * deleteRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:fetchRequest];
    @try {
        [_context.persistentStoreCoordinator executeRequest:deleteRequest withContext:_context error:nil];

    } @catch (NSException *exception) {
        NSLog(@"Failed to delete saved entries, error: %@", exception);
    } @finally {

    }
}

- (void)deleteRecordWithItem:(ImageAndText * _Nonnull)item { 
    
    NSManagedObjectID * objectID = item.dbid;
    if (objectID) {
        @try {
            NSManagedObject * objectToDelete = [_context existingObjectWithID:objectID error:nil];
            [_context deleteObject:objectToDelete];
            [_context save:nil];
            
        } @catch (NSException *exception) {
            NSLog(@"failed to delete an object from the database, error: %@", exception);
        } @finally {
            
        }
    }
}

- (NSArray<ImageAndText *> * _Nullable)load { 
    NSFetchRequest<Record *> * fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Record"];
    
    @try {
        NSArray *results = [_context executeFetchRequest:fetchRequest error:nil ];
        NSMutableArray *returnedResult = [[NSMutableArray alloc] init];
        int index = 0;
        for (index = 0; index < results.count; index++) {
            Record * item = results[index];
            UIImage *image = [[UIImage alloc] initWithData:[item image]];
            ImageAndText * imageAndText = [[ImageAndText alloc] initWithDbid:item.objectID image:image text:item.text];
            [returnedResult addObject:imageAndText];
        }
        return  returnedResult;
    } @catch (NSException * e) {
        NSLog(@"Error loading data form storage: %@", e);
        return nil;
    } @finally {
        
    }
}

- (ImageAndText * _Nonnull)saveWithItem:(ImageAndText * _Nonnull)item {
    
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Record" inManagedObjectContext:_context];
    Record * record = (Record*) [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:_context];
    UIImage * image = [item image];
    record.image = UIImagePNGRepresentation(image);
    record.text = item.text;
    if (_context.hasChanges) {
        
        @try {
           bool contextSaved =  [_context save:nil];
            if (contextSaved) {
                NSLog(@"Context saved.");
            }
            return [[ImageAndText alloc] initWithDbid:record.objectID image:item.image text:item.text];
        } @catch (NSException * e) {
            NSLog(@"Context not saved, exception: %@", e);
        } @finally {
            
        }
    }
    return item;
}

@end

