import Foundation

/// Represents HTTP response statuses with associated codes and reason phrases.
/// Conforms to `Sendable` for use in concurrent contexts.
public enum CSLHTTPResponseStatus: Sendable {
    
    // MARK: - Cases
    
    /// Custom status with a specified code and reason phrase.
    case custom(code: UInt, reasonPhrase: String)
    
    /// Informational responses (1xx).
    case `continue`, switchingProtocols, processing
    
    /// Successful responses (2xx).
    case ok, created, accepted, nonAuthoritativeInformation, noContent, resetContent,
         partialContent, multiStatus, alreadyReported, imUsed
    
    /// Redirection messages (3xx).
    case multipleChoices, movedPermanently, found, seeOther, notModified, useProxy,
         temporaryRedirect, permanentRedirect
    
    /// Client error responses (4xx).
    case badRequest, unauthorized, paymentRequired, forbidden, notFound,
         methodNotAllowed, notAcceptable, proxyAuthenticationRequired, requestTimeout,
         conflict, gone, lengthRequired, preconditionFailed, payloadTooLarge,
         uriTooLong, unsupportedMediaType, rangeNotSatisfiable, expectationFailed,
         imATeapot, misdirectedRequest, unprocessableEntity, locked, failedDependency,
         upgradeRequired, preconditionRequired, tooManyRequests, requestHeaderFieldsTooLarge,
         unavailableForLegalReasons
    
    /// Server error responses (5xx).
    case internalServerError, notImplemented, badGateway, serviceUnavailable,
         gatewayTimeout, httpVersionNotSupported, variantAlsoNegotiates,
         insufficientStorage, loopDetected, notExtended, networkAuthenticationRequired
    
    // MARK: - Initialization
    
    /// Initializes an `CSLHTTPResponseStatus` from a status code and optional reason phrase.
    /// - Parameters:
    ///   - statusCode: The numerical HTTP status code.
    ///   - reasonPhrase: The accompanying reason phrase.
    public init(statusCode: Int, reasonPhrase: String = "") {
        switch statusCode {
        case 100: self = .`continue`
        case 101: self = .switchingProtocols
        case 102: self = .processing
        case 200: self = .ok
        case 201: self = .created
        case 202: self = .accepted
        case 203: self = .nonAuthoritativeInformation
        case 204: self = .noContent
        case 205: self = .resetContent
        case 206: self = .partialContent
        case 207: self = .multiStatus
        case 208: self = .alreadyReported
        case 226: self = .imUsed
        case 300: self = .multipleChoices
        case 301: self = .movedPermanently
        case 302: self = .found
        case 303: self = .seeOther
        case 304: self = .notModified
        case 305: self = .useProxy
        case 307: self = .temporaryRedirect
        case 308: self = .permanentRedirect
        case 400: self = .badRequest
        case 401: self = .unauthorized
        case 402: self = .paymentRequired
        case 403: self = .forbidden
        case 404: self = .notFound
        case 405: self = .methodNotAllowed
        case 406: self = .notAcceptable
        case 407: self = .proxyAuthenticationRequired
        case 408: self = .requestTimeout
        case 409: self = .conflict
        case 410: self = .gone
        case 411: self = .lengthRequired
        case 412: self = .preconditionFailed
        case 413: self = .payloadTooLarge
        case 414: self = .uriTooLong
        case 415: self = .unsupportedMediaType
        case 416: self = .rangeNotSatisfiable
        case 417: self = .expectationFailed
        case 418: self = .imATeapot
        case 421: self = .misdirectedRequest
        case 422: self = .unprocessableEntity
        case 423: self = .locked
        case 424: self = .failedDependency
        case 426: self = .upgradeRequired
        case 428: self = .preconditionRequired
        case 429: self = .tooManyRequests
        case 431: self = .requestHeaderFieldsTooLarge
        case 451: self = .unavailableForLegalReasons
        case 500: self = .internalServerError
        case 501: self = .notImplemented
        case 502: self = .badGateway
        case 503: self = .serviceUnavailable
        case 504: self = .gatewayTimeout
        case 505: self = .httpVersionNotSupported
        case 506: self = .variantAlsoNegotiates
        case 507: self = .insufficientStorage
        case 508: self = .loopDetected
        case 510: self = .notExtended
        case 511: self = .networkAuthenticationRequired
        default: self = .custom(code: UInt(statusCode), reasonPhrase: reasonPhrase)
        }
    }
}

// MARK: - Properties

public extension CSLHTTPResponseStatus {
    
    /// The numerical status code associated with the HTTP response status.
    var code: UInt {
        switch self {
        case .continue: 100
        case .switchingProtocols: 101
        case .processing: 102
        case .ok: 200
        case .created: 201
        case .accepted: 202
        case .nonAuthoritativeInformation: 203
        case .noContent: 204
        case .resetContent: 205
        case .partialContent: 206
        case .multiStatus: 207
        case .alreadyReported: 208
        case .imUsed: 226
        case .multipleChoices: 300
        case .movedPermanently: 301
        case .found: 302
        case .seeOther: 303
        case .notModified: 304
        case .useProxy: 305
        case .temporaryRedirect: 307
        case .permanentRedirect: 308
        case .badRequest: 400
        case .unauthorized: 401
        case .paymentRequired: 402
        case .forbidden: 403
        case .notFound: 404
        case .methodNotAllowed: 405
        case .notAcceptable: 406
        case .proxyAuthenticationRequired: 407
        case .requestTimeout: 408
        case .conflict: 409
        case .gone: 410
        case .lengthRequired: 411
        case .preconditionFailed: 412
        case .payloadTooLarge: 413
        case .uriTooLong: 414
        case .unsupportedMediaType: 415
        case .rangeNotSatisfiable: 416
        case .expectationFailed: 417
        case .imATeapot: 418
        case .misdirectedRequest: 421
        case .unprocessableEntity: 422
        case .locked: 423
        case .failedDependency: 424
        case .upgradeRequired: 426
        case .preconditionRequired: 428
        case .tooManyRequests: 429
        case .requestHeaderFieldsTooLarge: 431
        case .unavailableForLegalReasons: 451
        case .internalServerError: 500
        case .notImplemented: 501
        case .badGateway: 502
        case .serviceUnavailable: 503
        case .gatewayTimeout: 504
        case .httpVersionNotSupported: 505
        case .variantAlsoNegotiates: 506
        case .insufficientStorage: 507
        case .loopDetected: 508
        case .notExtended: 510
        case .networkAuthenticationRequired: 511
        case .custom(let code, reasonPhrase: _): code
        }
    }
    
    /// The reason phrase associated with the HTTP response status.
    var reasonPhrase: String {
        switch self {
        case .continue: "Continue"
        case .switchingProtocols: "Switching Protocols"
        case .processing: "Processing"
        case .ok: "OK"
        case .created: "Created"
        case .accepted: "Accepted"
        case .nonAuthoritativeInformation: "Non-Authoritative Information"
        case .noContent: "No Content"
        case .resetContent: "Reset Content"
        case .partialContent: "Partial Content"
        case .multiStatus: "Multi-Status"
        case .alreadyReported: "Already Reported"
        case .imUsed: "IM Used"
        case .multipleChoices: "Multiple Choices"
        case .movedPermanently: "Moved Permanently"
        case .found: "Found"
        case .seeOther: "See Other"
        case .notModified: "Not Modified"
        case .useProxy: "Use Proxy"
        case .temporaryRedirect: "Temporary Redirect"
        case .permanentRedirect: "Permanent Redirect"
        case .badRequest: "Bad Request"
        case .unauthorized: "Unauthorized"
        case .paymentRequired: "Payment Required"
        case .forbidden: "Forbidden"
        case .notFound: "Not Found"
        case .methodNotAllowed: "Method Not Allowed"
        case .notAcceptable: "Not Acceptable"
        case .proxyAuthenticationRequired: "Proxy Authentication Required"
        case .requestTimeout: "Request Timeout"
        case .conflict: "Conflict"
        case .gone: "Gone"
        case .lengthRequired: "Length Required"
        case .preconditionFailed: "Precondition Failed"
        case .payloadTooLarge: "Payload Too Large"
        case .uriTooLong: "URI Too Long"
        case .unsupportedMediaType: "Unsupported Media Type"
        case .rangeNotSatisfiable: "Range Not Satisfiable"
        case .expectationFailed: "Expectation Failed"
        case .imATeapot: "I'm a teapot"
        case .misdirectedRequest: "Misdirected Request"
        case .unprocessableEntity: "Unprocessable Entity"
        case .locked: "Locked"
        case .failedDependency: "Failed Dependency"
        case .upgradeRequired: "Upgrade Required"
        case .preconditionRequired: "Precondition Required"
        case .tooManyRequests: "Too Many Requests"
        case .requestHeaderFieldsTooLarge: "Request Header Fields Too Large"
        case .unavailableForLegalReasons: "Unavailable For Legal Reasons"
        case .internalServerError: "Internal Server Error"
        case .notImplemented: "Not Implemented"
        case .badGateway: "Bad Gateway"
        case .serviceUnavailable: "Service Unavailable"
        case .gatewayTimeout: "Gateway Timeout"
        case .httpVersionNotSupported: "HTTP Version Not Supported"
        case .variantAlsoNegotiates: "Variant Also Negotiates"
        case .insufficientStorage: "Insufficient Storage"
        case .loopDetected: "Loop Detected"
        case .notExtended: "Not Extended"
        case .networkAuthenticationRequired: "Network Authentication Required"
        case .custom(code: _, reasonPhrase: let phrase): phrase
        }
    }
}
