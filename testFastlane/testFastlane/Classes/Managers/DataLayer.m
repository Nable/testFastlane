//
//  DataLayer.m
//  testFastlane
//
//  Created by Ennio Masi on 13/07/15.
//  Copyright (c) 2015 Vertical. All rights reserved.
//

#import "DataLayer.h"

#import "AppDelegate.h"

@implementation DataLayer

+ (id)sharedInstance {
    static DataLayer *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[DataLayer alloc] init];
    });
    
    return instance;
}

#pragma mark - Common
- (void) discardChanges: (NSManagedObject *) theObject {
    [theObject.managedObjectContext refreshObject:theObject mergeChanges:NO];
}

- (void) saveChanges {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    NSError *saveError = nil;
    if (![context save:&saveError]) {
        NSLog(@"Whoops, couldn't save: %@", [saveError localizedDescription]);
    }
}

- (NSManagedObject *) emptyObjectByEntityName: (NSString *) name {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObject *emptyObject = [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext: delegate.managedObjectContext];
    
    return emptyObject;
}

- (void) deleteEntity: (NSManagedObject *) entity {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.managedObjectContext deleteObject:entity];
    
    NSError *error;
    if (![delegate.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

@end
