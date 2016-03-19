//
//  ReminderUtility.m
//  testFastlane
//
//  Created by Alessandro Amoroso on 07/04/15.
//  Copyright (c) 2015 Vertical. All rights reserved.
//

#import "ReminderUtility.h"

static ReminderUtility *sharedInstance = nil;

@implementation ReminderUtility

+ (ReminderUtility *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[ReminderUtility alloc] init];
    }
    return sharedInstance;
}

+ (void)destroySharedInstance {
    sharedInstance = nil;
}

- (id)init {
    self = [super init];
    return self;
}

/**
 Remove all schedulated local notifications
*/
- (void) removeAllNotifications {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

/**
 Remove a specific schedulated local notification
 @param identifier
 The identifier of the notification.
 */
- (void) removeNotification: (NSString *) identifier {
    for(UILocalNotification *notification in [[UIApplication sharedApplication] scheduledLocalNotifications])
        if ([[notification.userInfo objectForKey:@"notificationIdentifier"] isEqualToString:identifier] )
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
}

- (bool) localNotificationExists: (NSString *) identifier {
    bool exists = NO;
    for(UILocalNotification *notification in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
        if ([[notification.userInfo objectForKey:@"notificationIdentifier"] isEqualToString:identifier] ) {
            exists =  YES;
            break;
        } else {
            exists =  NO;
        }
    }
    return exists;
}

/**
 Add a basic reminder
 @param identifier: The identifier of the notification.
 @param date: The date and time when the system should deliver the notification.
 @param body: The message displayed in the notification alert.
 @param withAction: The title of the action button or slider.
 @param withTitle: A short description of the reason for the alert.
 @param withLaunchImage: Identifies the image used as the launch image when the user taps (or slides) the action button (or slider)
 @param repeat: The interval at which to reschedule the notification.
 */
- (void) addReminder: (NSString *) identifier withDate: (NSDate *) date withBody: (NSString *) body withAction: (NSString *) action withTitle: (NSString *) title withLaunchImage: (NSString *) image repeat:(int) repeat {
    
    UILocalNotification* reminder = [[UILocalNotification alloc] init];
    reminder.fireDate = date;
    reminder.alertTitle = title;
    reminder.alertBody = body;
    reminder.alertAction = action;
    if (image)
        reminder.alertLaunchImage = image;
    reminder.userInfo = [NSDictionary dictionaryWithObject:identifier forKey:@"notificationIdentifier"];
    
    if (repeat == 0)
        reminder.repeatInterval =  NSCalendarUnitDay;
    else if (repeat == 1)
        reminder.repeatInterval =  NSCalendarUnitWeekOfYear;
    else if (repeat == 2)
        reminder.repeatInterval =  NSCalendarUnitMonth;
    
    //reminder.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification: reminder];
}


/**
 @param identifier: The identifier of the notification.
 @param categoryIdentifier: The name of a group of actions to display in the alert.
 @param date: The date and time when the system should deliver the notification.
 @param body: The message displayed in the notification alert.
 @param title: A short description of the reason for the alert.
 @param image: Identifies the image used as the launch image when the user taps (or slides) the action button (or slider)
 @param defaultActions:
 @param minimalActions:
 @param repeat: The interval at which to reschedule the notification.
 */
- (void) addMultiactionsReminder:(NSString *) identifier withCategoryIdentifier: (NSString *) categoryIdentifier withDate: (NSDate *) date withBody: (NSString *) body withTitle: (NSString *) title withLaunchImage: (NSString *) image withDefaultActions: (NSArray *) defaultActions withMinimalActions: (NSArray *) minimalActions repeat:(int) repeat {
    
    UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc] init];
    category.identifier = categoryIdentifier;
    
    [category setActions:defaultActions forContext:UIUserNotificationActionContextDefault];
    [category setActions:minimalActions forContext:UIUserNotificationActionContextMinimal];
    
    NSSet *categories = [NSSet setWithObject:category];
    UIUserNotificationType types = (UIUserNotificationTypeAlert| UIUserNotificationTypeSound| UIUserNotificationTypeBadge);
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    UILocalNotification* reminder = [[UILocalNotification alloc] init];
    reminder.fireDate = date;
    reminder.alertTitle = title;
    reminder.alertBody = body;
    reminder.category = categoryIdentifier;
    if (image)
        reminder.alertLaunchImage = image;
    
    if (repeat == 0)
        reminder.repeatInterval =  NSCalendarUnitDay;
    else if (repeat == 1)
        reminder.repeatInterval =  NSCalendarUnitWeekOfYear;
    else if (repeat == 2)
        reminder.repeatInterval =  NSCalendarUnitMonth;
    
    reminder.userInfo = [NSDictionary dictionaryWithObject:identifier forKey:@"notificationIdentifier"];
    [[UIApplication sharedApplication] scheduleLocalNotification: reminder];
}

@end