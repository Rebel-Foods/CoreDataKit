//
//  CKFetchedResultsController.m
//  FRC
//
//  Created by Raghav Ahuja on 11/12/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

#import "CKFetchedResultsController.h"

@implementation CKFetchedResultsController

//- (id<NSFetchedResultsControllerDelegate>)delegate {
//    return _safeDelegate;
//}
//- (void)setDelegate:(id<NSFetchedResultsControllerDelegate>)delegate {
//setSafeDelegate: delegate
//}

- (void)setSafeDelegate:(id<NSFetchedResultsControllerDelegate>)safeDelegate {
    [super setDelegate: safeDelegate];
    _safeDelegate = safeDelegate;
}

@end
