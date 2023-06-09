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

#if canImport(UIKit) && !os(watchOS)
import UIKit
#endif

/// This protocol defines how view controllers will be shown and dismissed.
public protocol Router: AnyObject {
    
    // MARK: Type aliases
    
    typealias OnDismissedClosure = () -> Void
    
    // MARK: Functions
    
    #if canImport(UIKit) && !os(watchOS)
    /// Present a view controller animatedly or not, depending on the given `animated` parameter, and also pass a closure that should be called on dismissal.
    /// - Parameters:
    ///   - viewController: A `UIViewController` view controller instance to present.
    ///   - animated: A boolean that represents whether the view controller should be dismissed animatedly or not.
    ///   - onDismiss: A closure to be called or executed when the presented view controller is dismissed.
    func present(
        _ viewController: UIViewController,
        animated: Bool,
        onDismiss: OnDismissedClosure?
    )
    #endif
    
    /// Dismiss a view controller animatedly or not, depending on the given `animated` parameter.
    /// - Parameter animated: A boolean that represents whether the view controller should be dismissed animatedly or not.
    func dismiss(animated: Bool)
    
}

#if canImport(UIKit) && !os(watchOS)
// MARK: - Router+Implementations

public extension Router {
    
    // MARK: Functions
    
    /// Present a view controller animatedly or not, depending on the given `animated` parameter.
    /// - Parameters:
    ///   - viewController: A `UIViewController` view controller instance to present.
    ///   - animated: A boolean that represents whether the view controller should be dismissed animatedly or not.
    func present(_ viewController: UIViewController, animated: Bool) {
        present(
            viewController,
            animated: animated,
            onDismiss: nil
        )
    }

}
#endif
