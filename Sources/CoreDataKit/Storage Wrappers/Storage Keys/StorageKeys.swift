//
//  StorageKeys.swift
//  CoreDataKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

public protocol StorageKeys: Hashable {
    var key: String { get }
}
