//
//  NSFetchRequest+TestEntity.swift
//  PersistenceTests
//
//  Created by Javier Cicchelli on 17/04/2023.
//  Copyright © 2023 Röck+Cöde. All rights reserved.
//

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
