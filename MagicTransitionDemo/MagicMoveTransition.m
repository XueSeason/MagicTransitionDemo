//
//  MagicMoveTransition.m
//  MagicTransitionDemo
//
//  Created by 薛纪杰 on 11/23/15.
//  Copyright © 2015 XueSeason. All rights reserved.
//

#import "MagicMoveTransition.h"

#import "MainCollectionViewCell.h"

#import "MainCollectionViewController.h"
#import "DetailViewController.h"

@implementation MagicMoveTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.6f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {

    MainCollectionViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    DetailViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    fromVC.indexPath = [[fromVC.collectionView indexPathsForSelectedItems] firstObject];
    MainCollectionViewCell *cell = (MainCollectionViewCell *)[fromVC.collectionView cellForItemAtIndexPath:fromVC.indexPath];
    
    UIView *snapShotView = [cell.imageView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = fromVC.finalCellRect = [containerView convertRect:cell.imageView.frame fromView:cell.imageView.superview];
    cell.imageView.hidden = YES;
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    toVC.imageView.hidden = YES;
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0f
         usingSpringWithDamping:0.6f
          initialSpringVelocity:1.0f
                        options:UIViewAnimationOptionCurveLinear animations:^{
                            [containerView layoutIfNeeded];
                            toVC.view.alpha = 1.0;
                            snapShotView.frame = [containerView convertRect:toVC.imageView.frame fromView:toVC.imageView.superview];
                        } completion:^(BOOL finished) {
                            toVC.imageView.hidden = NO;
                            cell.imageView.hidden = NO;
                            [snapShotView removeFromSuperview];
                            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                        }];
}

@end
