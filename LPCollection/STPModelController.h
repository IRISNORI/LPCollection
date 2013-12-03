//
//  STPModelController.h
//  LPCollection
//
//  Created by Muramoto on 2013/12/03.
//  Copyright (c) 2013年 Norikazu Muramoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STPDataViewController;

@interface STPModelController : NSObject <UIPageViewControllerDataSource>

- (STPDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(STPDataViewController *)viewController;

@end
