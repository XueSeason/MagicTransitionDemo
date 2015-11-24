//
//  MagicMoveInverseTransition.m
//  MagicTransitionDemo
//
//  Created by 薛纪杰 on 11/24/15.
//  Copyright © 2015 XueSeason. All rights reserved.
//

#import "MagicMoveInverseTransition.h"

#import "MainCollectionViewController.h"
#import "DetailViewController.h"
#import "MainCollectionViewCell.h"

@implementation MagicMoveInverseTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.6f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    DetailViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    MainCollectionViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];

    UIView *snapShotView = [fromVC.imageView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = [container convertRect:fromVC.imageView.frame fromView:fromVC.imageView.superview];
    fromVC.imageView.hidden = YES;
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0.0;
    MainCollectionViewCell *cell = (MainCollectionViewCell *)[toVC.collectionView cellForItemAtIndexPath:toVC.indexPath];
    cell.imageView.hidden = YES;
    
    [container addSubview:toVC.view];
    [container addSubview:snapShotView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVC.view.alpha = 1.0;
        snapShotView.frame = toVC.finalCellRect;
    } completion:^(BOOL finished) {
        [snapShotView removeFromSuperview];
        fromVC.imageView.hidden = NO;
        cell.imageView.hidden = NO;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}

@end
