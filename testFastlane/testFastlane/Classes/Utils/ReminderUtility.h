//
//  ReminderUtility.h
//  testFastlane
//
//  Created by Alessandro Amoroso on 07/04/15.
//  Copyright (c) 2015 Vertical. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ReminderUtility : NSObject

+ (ReminderUtility *)sharedInstance;
+ (void)destroySharedInstance;

- (void) addReminder: (NSString *) identifier withDate: (NSDate *) date withBody: (NSString *) body withAction: (NSString *) action withTitle: (NSString *) title withLaunchImage: (NSString *) image repeat:(int) repeat;

- (void) addMultiactionsReminder:(NSString *) identifier withCategoryIdentifier: (NSString *) categoryIdentifier withDate: (NSDate *) date withBody: (NSString *) body withTitle: (NSString *) title withLaunchImage: (NSString *) image withDefaultActions: (NSArray *) defaultActions withMinimalActions: (NSArray *) minimalActions repeat:(int) repeat;

- (void) removeAllNotifications;
- (void) removeNotification: (NSString *) identifier;
- (bool) localNotificationExists: (NSString *) identifier;

@end
