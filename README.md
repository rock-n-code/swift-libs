# SwiftLibs

This package contains the core building blocks that we, [Röck+Cöde](https://rock-n-code.com), usually use to build any kind of application written in the [Swift programming language](https://www.swift.org/documentation/).

## Libraries

This package contains several libraries which a developer can also use in their own codebase, and these libraries are grouped by a certain concern or purpose.

Currently, this package contains the following libraries:
* `Communications`: protocols, enumerations and a ready-to-use mock url class to build remote API services;
* `Coordination`: protocols to implement the [Coordinator pattern](https://khanlou.com/2015/01/the-coordinator/) and some ready-to-use platform-specific concrete routers; 
* `Core`: extensions we usually add to the base layer functionality and primitive types provided by the [Swift standard library](https://https://www.swift.org/documentation/#standard-library);
* `Dependencies`: a ready-to-use, simple [Dependency Injection](https://en.wikipedia.org/wiki/Dependency_injection) mechanism that levers heavily on the [dynamic property wrappers](https://www.hackingwithswift.com/plus/intermediate-swiftui/creating-a-custom-property-wrapper-using-dynamicproperty) provided by the [Swift programming language](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/#Projecting-a-Value-From-a-Property-Wrapper);
* `Persistence`: protocols, extensions and a ready-to-use fetcher class to simplify the building of the [CoreData](https://developer.apple.com/documentation/coredata) persistence layer;
