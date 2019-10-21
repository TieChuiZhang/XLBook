//
//  AppDelegate.h
//  XLBook
//
//  Created by Lee on 2019/10/21.
//  Copyright © 2019 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;



@end

