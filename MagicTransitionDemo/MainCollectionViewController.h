//
//  MainCollectionViewController.h
//  MagicTransitionDemo
//
//  Created by 薛纪杰 on 11/23/15.
//  Copyright © 2015 XueSeason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCollectionViewController : UICollectionViewController
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) CGRect finalCellRect;
@end
