//
//  STPAppDelegate.m
//  LPCollection
//
//  Created by Muramoto on 2013/12/03.
//  Copyright (c) 2013年 Norikazu Muramoto. All rights reserved.
//

#import "STPAppDelegate.h"
#import "STPTransitionManager.h"
#import "STPListViewController.h"
#import "STPPageViewController.h"

@interface STPAppDelegate () <UINavigationControllerDelegate, STPTransitionManagerDelegate>

@property (nonatomic) STPTransitionManager *transitionManager;
@property (nonatomic, strong) STPListViewController *collectionViewController;

@end

@implementation STPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    
    [navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    navigationController.navigationBar.shadowImage = [UIImage new];
    navigationController.navigationBar.translucent = YES;
    
    navigationController.delegate = self;
    

    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(320, 130);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    _collectionViewController = [[STPListViewController alloc] initWithCollectionViewLayout:layout];
    [navigationController setViewControllers:@[_collectionViewController]];
    _transitionManager = [[STPTransitionManager alloc] initWithCollectionView:_collectionViewController.collectionView];
    self.transitionManager.delegate = self;
    //self.transitionManager.pagingDalegate = _collectionViewController;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - TransitionControllerDelegate

- (void)interactionBeganAtPoint:(CGPoint)point
{
    UINavigationController *navController = (UINavigationController *)self.window.rootViewController;
    UIViewController *viewController =
    [(STPCollectionViewController *)navController.topViewController nextViewControllerAtPoint:point];
    if (viewController != nil) {
        
        [navController pushViewController:viewController animated:YES];
    } else {
        [navController popViewControllerAnimated:YES];
    }
}

- (void)interactionBeganAtIndexPath:(NSIndexPath *)indexPath
{
    UINavigationController *navController = (UINavigationController *)self.window.rootViewController;
    UIViewController *viewController =
    [(STPCollectionViewController *)navController.topViewController nextViewControllerAtIndexPath:indexPath];
    if (viewController != nil) {
        //self.transitionManager.viewDelegate = (STPPageViewController *)viewController;
        [navController pushViewController:viewController animated:YES];
    } else {
        [navController popViewControllerAnimated:YES];
    }
}

#pragma mark - UINavigationControllerDelegate

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    // return our own transition manager if the incoming controller matches ours
    //if (animationController == self.transitionManager){
        return self.transitionManager;
    //}
    //return nil;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    id transitionManager = nil;
    
    if ([toVC isKindOfClass:[STPPageViewController class]]) {
        self.transitionManager.viewDelegate = (STPPageViewController *)toVC;
    }
    
    // make sure we are transitioning from or to a collection view controller, and that interaction is allowed
    if ([fromVC isKindOfClass:[UICollectionViewController class]] &&
        [toVC isKindOfClass:[UICollectionViewController class]] &&
        self.transitionManager.hasActiveInteraction)
    {
        self.transitionManager.navigationOperation = operation;
        transitionManager = self.transitionManager;
    } else {
        transitionManager = self.transitionManager;
    }
    return transitionManager;
}

@end
