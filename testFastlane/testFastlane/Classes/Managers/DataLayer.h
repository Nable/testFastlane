//
//  DataLayer.h
//  testFastlane
//
//  Created by Alessandro Amoroso on 07/04/15.
//  Copyright (c) 2015 Vertical. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataLayer : NSObject

+ (id)sharedInstance;

#pragma mark - Common
//- (NSManagedObject *) emptyObjectByEntityName: (NSString *) name;
//- (void) discardChanges: (NSManagedObject *) theObject;
- (void) saveChanges;
//- (void) deleteEntity: (NSManagedObject *) entity;

@end
