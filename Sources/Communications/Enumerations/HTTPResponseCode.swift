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

public enum HTTPResponseCode: Int {
    
    // MARK: Information
    
    /// This interim response indicates that the client should continue the request or ignore the response if the request is already finished.
    case `continue` = 100
    
    /// This code is sent in response to an Upgrade request header from the client and indicates the protocol the server is switching to.
    case switchingProtocols = 101
    
    /// *[WebDAV]* This code indicates that the server has received and is processing the request, but no response is available yet.
    case processing = 102
    
    /// This status code is primarily intended to be used with the Link header, letting the user agent start preloading resources while the server prepares a response.
    case earlyHints = 103
    
    // MARK: Success

    /// The request succeeded.
    case ok = 200
    
    /// The request, succeeded, and a new resource was created as a result as this is usually used in **POST** and **PUT** requests.
    case created = 201
    
    /// The request has been received but not yet acted upon, as no later asynchronous message will be sent indicating the outcome of the request. This is intended for cases where another server handles the request, or for batch processing.
    case accepted = 202
    
    /// The returned metadata is not exactly the same as is available from the origin server, but is collected from a local or 3rd party copy. This is intended to be used for mirrors or backups of another resource.
    case nonAuthoritativeInformation = 203
    
    /// No content to send for this request, but the headers may be useful, as the user agent may update its cached header for this resource for new ones.
    case noContent = 204
    
    /// Tells the user agent to reset the document which sent this request.
    case resetContent = 205
    
    /// Used when the **Range** header is sent from the client to request only part of a resource.
    case partialContent = 206
    
    /// *[WebDAV]* Conveys information about multiple resources, for situation where multiple status codes might be appropriate.
    case multiStatus = 207
    
    /// *[WebDAV]* Avoids repeatedly enumerating the internal numbers of multiple bindings to the same collection, as it is used inside a `dav:prostat` response element.
    case alreadyReported = 208
    
    /// *[HTTP delta encoding]* Indicates the server has fulfilled a GET request for the resource, and the response is a representation of the result of one or more instance-manipulations applied to the current instance.
    case imUsed = 226
    
    // MARK: Redirection
    
    /// The request has more than one possible response. The user agent or user should choose one of them. (There is no standardized way of choosing one of the responses, but HTML links to the possibilities are recommended so the user can pick.)
    case multipleChoices = 300
    
    /// The URL of the requested resource has been changed permanently. The new URL is given in the response.
    case movedPermanetly = 301
    
    /// This response code means that the URI of requested resource has been changed temporarily. Further changes in the URI might be made in the future. Therefore, this same URI should be used by the client in future requests.
    case found = 302
    
    /// The server sent this response to direct the client to get the requested resource at another URI with a GET request.
    case seeOther = 303
    
    /// This is used for caching purposes. It tells the client that the response has not been modified, so the client can continue to use the same cached version of the response.
    case notModified = 304
    
    /// Defined in a previous version of the HTTP specification to indicate that a requested response must be accessed by a proxy. It has been deprecated due to security concerns regarding in-band configuration of a proxy.
    case useProxy = 305
    
    /// This response code is no longer used; it is just reserved. It was used in a previous version of the HTTP/1.1 specification.
    case unused = 306
    
    /// The server sends this response to direct the client to get the requested resource at another URI with the same method that was used in the prior request. This has the same semantics as the 302 Found HTTP response code, with the exception that the user agent must not change the HTTP method used: if a POST was used in the first request, a POST must be used in the second request.
    case temporaryRedirect = 307
    
    /// This means that the resource is now permanently located at another URI, specified by the Location: HTTP Response header. This has the same semantics as the 301 Moved Permanently HTTP response code, with the exception that the user agent must not change the HTTP method used: if a POST was used in the first request, a POST must be used in the second request.
    case permanentRedirect = 308

    // MARK: Client error
    
    /// The server cannot or will not process the request due to something that is perceived to be a client error (e.g., malformed request syntax, invalid request message framing, or deceptive request routing).
    case badRequest = 400
    
    /// Although the HTTP standard specifies "unauthorized", semantically this response means "unauthenticated". That is, the client must authenticate itself to get the requested response.
    case unauthorized = 401
    
    /// This response code is reserved for future use. The initial aim for creating this code was using it for digital payment systems, however this status code is used very rarely and no standard convention exists.
    case paymentRequired = 402
    
    /// The client does not have access rights to the content; that is, it is unauthorized, so the server is refusing to give the requested resource. Unlike 401 Unauthorized, the client's identity is known to the server.
    case forbidden = 403
    
    /// The server cannot find the requested resource. In the browser, this means the URL is not recognized. In an API, this can also mean that the endpoint is valid but the resource itself does not exist. Servers may also send this response instead of 403 Forbidden to hide the existence of a resource from an unauthorized client. This response code is probably the most well known due to its frequent occurrence on the web.
    case notFound = 404
    
    /// The request method is known by the server but is not supported by the target resource. For example, an API may not allow calling DELETE to remove a resource.
    case methodNotAllowed = 405
    
    /// This response is sent when the web server, after performing server-driven content negotiation, doesn't find any content that conforms to the criteria given by the user agent.
    case notAcceptable = 406
    
    /// This is similar to 401 Unauthorized but authentication is needed to be done by a proxy.
    case proxyAuthenticationRequired = 407
    
    /// This response is sent on an idle connection by some servers, even without any previous request by the client. It means that the server would like to shut down this unused connection. This response is used much more since some browsers, like Chrome, Firefox 27+, or IE9, use HTTP pre-connection mechanisms to speed up surfing. Also note that some servers merely shut down the connection without sending this message.
    case requestTimeout = 408
    
    /// This response is sent when a request conflicts with the current state of the server.
    case conflict = 409
    
    /// This response is sent when the requested content has been permanently deleted from server, with no forwarding address. Clients are expected to remove their caches and links to the resource. The HTTP specification intends this status code to be used for "limited-time, promotional services". APIs should not feel compelled to indicate resources that have been deleted with this status code.
    case gone = 410
    
    /// Server rejected the request because the Content-Length header field is not defined and the server requires it.
    case lengthRequired = 411
    
    /// The client has indicated preconditions in its headers which the server does not meet.
    case preconditionFailed = 412
    
    /// Request entity is larger than limits defined by server. The server might close the connection or return an Retry-After header field.
    case payloadTooLarge = 413
    
    /// The URI requested by the client is longer than the server is willing to interpret.
    case uriTooLong = 414
    
    /// The media format of the requested data is not supported by the server, so the server is rejecting the request.
    case unsupportedMediaType = 415
    
    /// The range specified by the Range header field in the request cannot be fulfilled. It's possible that the range is outside the size of the target URI's data.
    case rangeNotSatisfiable = 416
    
    /// This response code means the expectation indicated by the Expect request header field cannot be met by the server.
    case expectationFailed = 417
    
    /// The server refuses the attempt to brew coffee with a teapot.
    case imATeapot = 418
    
    /// The request was directed at a server that is not able to produce a response. This can be sent by a server that is not configured to produce responses for the combination of scheme and authority that are included in the request URI.
    case misdirectedRequest = 421
    
    /// *[WebDAV]* The request was well-formed but was unable to be followed due to semantic errors.
    case unprocessableContent = 422
    
    /// *[WebDAV]* The resource that is being accessed is locked.
    case locked = 423
    
    /// *[WebDAV]* The request failed due to failure of a previous request.
    case failedDependency = 424
    
    /// Indicates that the server is unwilling to risk processing a request that might be replayed.
    case tooEarly = 425
    
    /// The server refuses to perform the request using the current protocol but might be willing to do so after the client upgrades to a different protocol. The server sends an Upgrade header in a 426 response to indicate the required protocol(s).
    case upgradeRequired = 426
    
    /// The origin server requires the request to be conditional. This response is intended to prevent the 'lost update' problem, where a client GETs a resource's state, modifies it and PUTs it back to the server, when meanwhile a third party has modified the state on the server, leading to a conflict.
    case preconditionRequired = 428
    
    /// The user has sent too many requests in a given amount of time ("rate limiting").
    case tooManyRequests = 429
    
    /// The server is unwilling to process the request because its header fields are too large. The request may be resubmitted after reducing the size of the request header fields.
    case requestHeaderFieldsTooLarge = 431
    
    /// The user agent requested a resource that cannot legally be provided, such as a web page censored by a government.
    case unavailableForLegalReasons = 451
    
    // MARK: Server error
    
    /// The server has encountered a situation it does not know how to handle.
    case internalServerError = 500
    
    /// The request method is not supported by the server and cannot be handled. The only methods that servers are required to support (and therefore that must not return this code) are GET and HEAD.
    case notImplemented = 501
    
    /// This error response means that the server, while working as a gateway to get a response needed to handle the request, got an invalid response.
    case badGateway = 502
    
    /// The server is not ready to handle the request. Common causes are a server that is down for maintenance or that is overloaded. Note that together with this response, a user-friendly page explaining the problem should be sent. This response should be used for temporary conditions and the Retry-After HTTP header should, if possible, contain the estimated time before the recovery of the service. The webmaster must also take care about the caching-related headers that are sent along with this response, as these temporary condition responses should usually not be cached.
    case serviceUnavailable = 503
    
    /// This error response is given when the server is acting as a gateway and cannot get a response in time.
    case gatewayTimeout = 504
    
    /// The HTTP version used in the request is not supported by the server.
    case httpVersionNotSupported = 505
    
    /// The server has an internal configuration error: the chosen variant resource is configured to engage in transparent content negotiation itself, and is therefore not a proper end point in the negotiation process.
    case variantAlsoNegotiates = 506
    
    /// *[WebDAV]* The method could not be performed on the resource because the server is unable to store the representation needed to successfully complete the request.
    case insufficientStorage = 507
    
    /// *[WebDAV]* The server detected an infinite loop while processing the request.
    case loopDetected = 508
    
    /// Further extensions to the request are required for the server to fulfill it.
    case notExtended = 510
    
    /// Indicates that the client needs to authenticate to gain network access.
    case networkAuthenticationRequired = 511
}
