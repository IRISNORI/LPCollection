//
//  STPListViewController.m
//  LPCollection
//
//  Created by Muramoto on 2013/12/03.
//  Copyright (c) 2013年 Norikazu Muramoto. All rights reserved.
//

#import "STPListViewController.h"
#import "STPPageViewController.h"
#import "STPPickUpLayout.h"

@interface STPListViewController ()

@end

@implementation STPListViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(www)];
    //self.navigationItem.rightBarButtonItem = addButton;
	// Do any additional setup after loading the view.
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *controller = [self nextViewControllerAtIndexPath:indexPath
                                    ];
    [self.navigationController pushViewController:controller animated:YES];
}


- (UICollectionViewController*)nextViewControllerAtPoint:(CGPoint)point
{
    // We could have multiple section stacks and find the right one,
    STPPickUpLayout *layout = [STPPickUpLayout new];
    
    layout.itemSize = CGSizeMake(320, 130);
    layout.selectedItemSize = [UIScreen mainScreen].bounds.size;
    
    STPPageViewController* nextCollectionViewController = [[STPPageViewController alloc] initWithCollectionViewLayout:layout];
    nextCollectionViewController.useLayoutToLayoutNavigationTransitions = YES;
    nextCollectionViewController.title = @"Layout 2";
    return nextCollectionViewController;
}

- (UICollectionViewController*)nextViewControllerAtIndexPath:(NSIndexPath *)indexPath
{
    // We could have multiple section stacks and find the right one,
    STPPickUpLayout *layout = [STPPickUpLayout new];
    
    layout.itemSize = CGSizeMake(320, 130);
    layout.selectedItemSize = [UIScreen mainScreen].bounds.size;
    layout.selectedIndexPath = indexPath;
    
    STPPageViewController* nextCollectionViewController = [[STPPageViewController alloc] initWithCollectionViewLayout:layout];
    nextCollectionViewController.useLayoutToLayoutNavigationTransitions = YES;
    nextCollectionViewController.title = @"Layout 2";
    return nextCollectionViewController;
}





@end
