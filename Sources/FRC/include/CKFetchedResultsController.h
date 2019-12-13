//
//  CKFetchedResultsController.h
//  FRC
//
//  Created by Raghav Ahuja on 11/12/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface CKFetchedResultsController<ResultType: id<NSFetchRequestResult>> : NSFetchedResultsController<ResultType>

@property(nullable, nonatomic, weak) id< NSFetchedResultsControllerDelegate > safeDelegate;

- (void)setSafeDelegate:(id<NSFetchedResultsControllerDelegate>)safeDelegate;

@end

NS_ASSUME_NONNULL_END
