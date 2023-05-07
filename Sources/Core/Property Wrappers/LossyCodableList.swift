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

@propertyWrapper
/// This property wrapper provides a generic type that acts as a thin wrapper around an array of `Elements` instances to allow a lossy decoding and or encoding process.
public struct LossyCodableList<Element> {
    
    // MARK: Properties
    
    private var elements: [Element]
    
    /// Provides read/write access to the array of `Element` instances.
    public var wrappedValue: [Element] {
        get { elements }
        set { elements = newValue }
    }
    
    // MARK: Initialisers
    
    /// Initialises this property wrapper.
    public init() {
        self.elements = []
    }

}

// MARK: - Decodable

extension LossyCodableList: Decodable where Element: Decodable {
    
    // MARK: Initialisers
    
    /// Initialises the struct with a lossy decoder.
    /// - Parameter decoder: The decoder to use for the lossy decoder process.
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let wrappers = try container.decode([ElementWrapper].self)
        
        self.elements = wrappers.compactMap(\.element)
    }

}

// MARK: - Encodable

extension LossyCodableList: Encodable where Element: Encodable {
    
    // MARK: Functions
    
    /// Encodes an array of `Element` instances loosely.
    /// - Parameter encoder: The encoder to use for the lossy encoding process.
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        
        elements.forEach { element in
            try? container.encode(element)
        }
    }

}

// MARK: - Structs

private extension LossyCodableList where Element: Decodable {
    struct ElementWrapper: Decodable {
        
        // MARK: Properties
        
        var element: Element?
        
        // MARK: Initialisers
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            
            self.element = try? container.decode(Element.self)
        }

    }
}
