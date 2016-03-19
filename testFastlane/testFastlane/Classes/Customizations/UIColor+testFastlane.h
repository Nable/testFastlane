//
//  UIColor+testFastlane.h
//  testFastlane
//
//  Created by Ennio Masi on 09/06/15.
//  Copyright (c) 2015 Vertical. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (testFastlane)

// Generic
+ (UIColor *) viewBackground;
+ (UIColor *) alertBackground;

// NavBar
+ (UIColor *) navBarTint;

// Left Menu
+ (UIColor *) leftMenuSelectedCell;
+ (UIColor *) textFieldBorderColor;

+ (UIColor *) switchColor;
+ (UIColor *) sliderColor;

@end
