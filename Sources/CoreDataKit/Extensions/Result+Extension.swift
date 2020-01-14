//
//  Result+Extension.swift
//  CoreDataKit
//
//  Created by Raghav Ahuja on 18/10/19.
//  Copyright © 2019 Raghav Ahuja. All rights reserved.
//

import Foundation

extension Result {
    
    func getError() -> Error? {
        switch self {
        case .success: return nil
        case .failure(let error): return error
        }
    }
}
