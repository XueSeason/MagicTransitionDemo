//
//  MainCollectionViewController.m
//  MagicTransitionDemo
//
//  Created by 薛纪杰 on 11/23/15.
//  Copyright © 2015 XueSeason. All rights reserved.
//

#import "MainCollectionViewController.h"

#import "MainCollectionViewCell.h"
#import "DetailViewController.h"

#import "MagicMoveTransition.h"

@interface MainCollectionViewController () <UINavigationControllerDelegate>
@property (strong, nonatomic) MagicMoveTransition *pushTransition;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactionController;
@end

@implementation MainCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}

#pragma mark - getters and setters
- (MagicMoveTransition *)pushTransition {
    if (!_pushTransition) {
        _pushTransition = [[MagicMoveTransition alloc] init];
    }
    return _pushTransition;
}

#pragma mark <UINavigationControllerDelegate>
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush && [toVC isKindOfClass:[DetailViewController class]]) {
        return self.pushTransition;
    }else{
        return nil;
    }
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController*)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactionController;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

@end
