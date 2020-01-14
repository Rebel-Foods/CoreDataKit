//
//  CKObjectIdResultsController.h
//  FRC
//
//  Created by Raghav Ahuja on 11/12/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

#import "CKFetchedResultsController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CKObjectIdResultsController<ResultType: NSManagedObjectID *> : CKFetchedResultsController<ResultType>


@end

NS_ASSUME_NONNULL_END
