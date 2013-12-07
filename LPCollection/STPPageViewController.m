//
//  STPPageViewController.m
//  LPCollection
//
//  Created by Muramoto on 2013/12/03.
//  Copyright (c) 2013年 Norikazu Muramoto. All rights reserved.
//

#import "STPPageViewController.h"

@interface STPPageViewController ()

@end

@implementation STPPageViewController

- (STPRootViewController *)pagingViewController
{
    if (!_pagingViewController) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _pagingViewController = [storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
    }
    return _pagingViewController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self addChildViewController:self.pagingViewController];
    [self.pagingViewController didMoveToParentViewController:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.pagingViewController willMoveToParentViewController:self];
    [self.pagingViewController removeFromParentViewController];
    [super viewDidDisappear:animated];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    STPListPickUpCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.listPickUpCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithHue:1.0f/20 * indexPath.row saturation:1 brightness:1 alpha:1];
    return cell;
}

#pragma mark - TransitionViewDelegate

- (void)selectedIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    ((STPPickUpLayout *)self.collectionView.collectionViewLayout).selectedIndexPath = indexPath;
    ((STPPickUpLayout *)self.collectionViewLayout).selectedIndexPath = indexPath;
}

- (void)startWithIndexPath:(NSIndexPath *)indexPath presenting:(BOOL)present
{
    if (present) {
        self.pagingViewController.view.alpha = 0.0f;
        STPListPickUpCell *cell = (STPListPickUpCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        [cell addSubview:self.pagingViewController.view];
    }
    
}

- (void)startAnimation:(NSTimeInterval)transitionDuration presenting:(BOOL)present
{
    if (present) {
        self.pagingViewController.view.alpha = 0.0f;
        STPListPickUpCell *cell = (STPListPickUpCell *)[self.collectionView cellForItemAtIndexPath:self.selectedIndexPath];
        [cell addSubview:self.pagingViewController.view];
        [UIView animateWithDuration:transitionDuration delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.pagingViewController.view.alpha = 1.0f;
        } completion:^(BOOL finished) {
            
        }];
    } else {
        [UIView animateWithDuration:transitionDuration delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.pagingViewController.view.alpha = 0.0f;
        } completion:^(BOOL finished) {
            
        }];
    }
    
}

- (void)updateWithProgress:(CGFloat)progress presenting:(BOOL)present
{
    if (present) {
        self.pagingViewController.view.alpha = progress;
    } else {
        self.pagingViewController.view.alpha = 1.0f - progress;
    }
}

- (void)finishInteractiveTransition:(CGFloat)progress presenting:(BOOL)present
{
    if (present) {
        self.pagingViewController.view.alpha = 1.0f;
    } else {
        self.pagingViewController.view.alpha = 0.0f;
        [self.pagingViewController.view willMoveToSuperview:nil];
        [self.pagingViewController.view removeFromSuperview];
    }
}

- (void)cancelInteractiveTransition:(CGFloat)progress presenting:(BOOL)present
{
    if (present) {
        self.pagingViewController.view.alpha = 0.0f;
    } else {
        self.pagingViewController.view.alpha = 1.0f;
    }
}


@end
