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

/// This protocol organize the flow logic between view controllers in the app.
public protocol Coordinator: AnyObject {

    // MARK: Properties
    
    /// The child coordinators that are being currently presented.
    var children: [Coordinator] { get set }
    
    /// The router that handles how the view controllers in the coordinators will be shown or dismissed.
    var router: Router { get }

    // MARK: Functions
    
    /// Present the coordinator animatedly or not, depending on the given `animated` parameter, and also pass a closure that should be called on dismissal.
    /// - Parameters:
    ///   - animated: A boolean that represents whether the coordinator should be dismissed animatedly or not.
    ///   - onDismiss: A closure to be called or executed when the presented coordinator is dismissed.
    func present(animated: Bool, onDismiss: Router.OnDismissedClosure?)

}

// MARK: - Coordinator+Implementations

public extension Coordinator {
    
    /// Present a child coordinator animatedly or not, depending on the given `animated` parameter, and also pass a closure that should be called on dismissal.
    /// - Parameters:
    ///   - child: A child coordinator to be presented.
    ///   - animated: A boolean that represents whether the coordinator should be dismissed animatedly or not.
    ///   - onDismiss: A closure to be called or executed when the presented coordinator is dismissed.
    func present(
        child: Coordinator,
        animated: Bool,
        onDismiss: Router.OnDismissedClosure? = nil
    ) {
        store(child)
        child.present(animated: animated) { [weak self, weak child] in
            guard let self, let child else {
                return
            }
            
            self.free(child)
            onDismiss?()
        }
    }
    
    /// Dismiss the coordinator animatedly or not, depending on the given `animated` parameter.
    /// - Parameter animated: A boolean that represents whether the coordinator should be dismissed animatedly or not.
    func dismiss(animated: Bool) {
        router.dismiss(animated: animated)
    }

}

// MARK: - Helpers

private extension Coordinator {
    
    // MARK: Functions
    
    func store(_ coordinator: Coordinator) {
        children.append(coordinator)
    }
    
    func free(_ coordinator: Coordinator) {
        children = children.filter { $0 !== coordinator }
    }
}
