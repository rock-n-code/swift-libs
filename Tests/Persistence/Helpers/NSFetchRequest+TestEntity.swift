//===----------------------------------------------------------------------===//
//
// This source file is part of the SwiftLibs open source project
//
// Copyright (c) 2023 Röck+Cöde VoF. and the SwiftLibs project authors
// Licensed under the EUPL 1.2 or later.
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of SwiftLibs project authors
//
//===----------------------------------------------------------------------===//

import CoreData

extension NSFetchRequest where ResultType == TestEntity {
    
    // MARK: Functions
    
    static func allTestEntities() -> NSFetchRequest<TestEntity> {
        let request = TestEntity.fetchRequest()
        
        request.sortDescriptors = []
        request.resultType = .managedObjectResultType
        
        return request
    }

}
