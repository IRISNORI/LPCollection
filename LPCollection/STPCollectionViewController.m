//
//  STPCollectionViewController.m
//  LPInterface
//
//  Created by Muramoto on 2013/11/29.
//  Copyright (c) 2013年 Norikazu Muramoto. All rights reserved.
//

#import "STPCollectionViewController.h"

@interface STPCollectionViewController ()

@end

@implementation STPCollectionViewController

- (NSString *)listCellIdentifier
{
    return @"ListCell";
}

- (NSString *)pickUpCellIdentifier
{
    return @"PickUpCell";
}

- (NSString *)listPickUpCellIdentifier
{
    return @"listPickUpCell";
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCollectionViewLayout:(UICollectionViewFlowLayout *)layout
{
    if (self = [super initWithCollectionViewLayout:layout])
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.collectionView registerClass:[STPListPickUpCell class] forCellWithReuseIdentifier:self.listPickUpCellIdentifier];
}
/*
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear");
}
*/

- (UICollectionViewController *)nextViewControllerAtPoint:(CGPoint)point
{
    self.selectedIndexPath = [self.collectionView indexPathForItemAtPoint:point];
    return nil;
}


- (UICollectionViewController *)nextViewControllerAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    return nil;
}

- (void)setSelectedIndexPath:(NSIndexPath *)selectedIndexPath
{
    _selectedIndexPath = selectedIndexPath;
    NSLog(@"path* %@", _selectedIndexPath);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    STPListPickUpCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.listPickUpCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithHue:1.0f/20 * indexPath.row saturation:1 brightness:1 alpha:1];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UICollectionViewTransitionLayout *)collectionView:(UICollectionView *)collectionView transitionLayoutForOldLayout:(UICollectionViewLayout *)fromLayout newLayout:(UICollectionViewLayout *)toLayout
{
    UICollectionViewTransitionLayout *layout = [[UICollectionViewTransitionLayout alloc] initWithCurrentLayout:fromLayout nextLayout:toLayout];
    
    return layout;
}


@end
