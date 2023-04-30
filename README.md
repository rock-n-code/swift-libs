<center>
    <picture>
        <source srcset="imgs/swiftlibs-logo-dark.svg" media="(prefers-color-scheme: dark)">
        <img src="imgs/swiftlibs-logo-light.svg" alt="Shows the hand-drawn SwiftLibs package logo centered in the page.">
    </picture>
</center>

# SwiftLibs

This package contains the core building blocks that we, [Röck+Cöde](https://rock-n-code.com), usually use to build our libraries and application written in the [Swift programming language](https://www.swift.org/documentation/).

## Libraries

This package contains several libraries which can be imported, and these libraries are grouped by a certain concern, feature or purpose.

To provide further details about the libraries included in this package:
* `Communications`: protocols, enumerations and a ready-to-use mock url class to build remote API services;
* `Coordination`: protocols to implement the [Coordinator pattern](https://khanlou.com/2015/01/the-coordinator/) and some ready-to-use platform-specific concrete routers; 
* `Core`: extensions we usually add to the base layer functionality and primitive types provided by the [Swift standard library](https://https://www.swift.org/documentation/#standard-library);
* `Dependencies`: a ready-to-use, simple [Dependency Injection](https://en.wikipedia.org/wiki/Dependency_injection) mechanism that levers heavily on the [dynamic property wrappers](https://www.hackingwithswift.com/plus/intermediate-swiftui/creating-a-custom-property-wrapper-using-dynamicproperty) provided by the [Swift programming language](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/#Projecting-a-Value-From-a-Property-Wrapper);
* `Persistence` (*available for Apple platforms only*): protocols, extensions and a ready-to-use fetcher class to simplify the building of the [CoreData](https://developer.apple.com/documentation/coredata) persistence layer;

## Installation

It is possible to add this package to other libraries and applications by adding it as a dependency in a `Package.swift` file or in a Xcode project, through the *Package dependencies* interface.

This package has minimum platform requirements that are important to take into account:
* *iOS 15.0 or higher*;
* *macOS 12.0 or higher*;
* *tvOS 15.0 or higher*;
* *watchOS 8.0 or higher*.

### Package file

In the intended `Package.swift` file, it is required to add the following dependency:

```swift
dependencies: [
    // ...
    .package(url: "https://github.com/rock-n-code/swift-libs.git", from: "0.1.5")
    // ...
],
```

Then it is required to add the package to your target, like this:

```swift
targets: [
    .target(
        // ...
        dependencies: [
            .product(name: "SwiftLibs", package: "swift-libs")
        ],
        // ...
    ),
]
```

### Xcode 

In an opened Xcode project, it is required to follow these steps to install the package:

1. click on the Xcode project file in the sidebar to display *Project* and *Targets*;
2. select the project under the *Project* section to show the *Info*, *Build Settings* and *Package Dependencies* options in the center menu just right on top;
3. select the *Package Dependencies* option to show the defined dependencies of the project;
4. press on the *+* (plus) button to add dependencies to the project;
5. enter the URL `https://github.com/rock-n-code/swift-libs.git` into the *Search or Enter Package URL* located in the upper right corner;
6. select the retrieved option;
7. define the dependency rule (the *Up to Next Major Version* option and the *0.1.5* text are recommended);
8. select the target to which the dependency will be applied (if required);
9. wait for the package to be resolved and included in the project;
10. now you should be ready to start using this package!

### Other considerations

This library is fully supported on Apple platforms: *iOS*, *macOS*, *tvOS*, and *watchOS*. In addition, basic support for *Linux* platform has been added as well, but it is rather limited for the time being. It is just a matter of time, though, as the Foundation framework is [moving towards cross-platform support](https://www.swift.org/blog/foundation-preview-now-available) by moving away from its dependency on legacy Objective-C components. 

⚠️ Please notice that this library only supports the [Swift Package Manager](https://www.swift.org/package-manager/), and that support for other dependency managers such as *Cocoapods* and *Carthage* has not been prioritised. 
