//
//  DetailViewController.m
//  MagicTransitionDemo
//
//  Created by 薛纪杰 on 11/23/15.
//  Copyright © 2015 XueSeason. All rights reserved.
//

#import "DetailViewController.h"

#import "MainCollectionViewController.h"
#import "MagicMoveInverseTransition.h"

@interface DetailViewController () <UINavigationControllerDelegate>
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactivePopTransition;
@property (strong, nonatomic) MagicMoveInverseTransition *inverseTransition;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScreenEdgePanGestureRecognizer *popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePopRecognizer:)];
    popRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:popRecognizer];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - events response
- (void)handlePopRecognizer:(UIScreenEdgePanGestureRecognizer *)recognizer {

    CGFloat progress = [recognizer translationInView:self.view].x / self.view.bounds.size.width;
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        if (progress > 0.5) {
            [self.interactivePopTransition finishInteractiveTransition];
        }
        else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        
        self.interactivePopTransition = nil;
    }
}

#pragma mark - <UINavigationControllerDelegate>
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    if ([animationController isKindOfClass:[MagicMoveInverseTransition class]]) {
        return self.interactivePopTransition;
    }else{
        return nil;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if ([toVC isKindOfClass:[MainCollectionViewController class]]) {
        return self.inverseTransition;
    }else{
        return nil;
    }
}

#pragma mark - getters and setters
- (MagicMoveInverseTransition *)inverseTransition {
    if (!_inverseTransition) {
        _inverseTransition = [[MagicMoveInverseTransition alloc] init];
    }
    return _inverseTransition;
}

@end
