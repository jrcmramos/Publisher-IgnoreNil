//

import Foundation
import Combine

public protocol OptionalType {
    associatedtype Wrapped

    var optional: Wrapped? { get }
}

extension Optional: OptionalType {
    public var optional: Wrapped? { self }
}

extension Publisher where Output: OptionalType {
    public func ignoreNil() -> AnyPublisher<Output.Wrapped, Failure> {
        flatMap { output -> AnyPublisher<Output.Wrapped, Failure> in
            guard let output = output.optional
                else { return Empty<Output.Wrapped, Failure>(completeImmediately: false).eraseToAnyPublisher() }
            return Just(output).setFailureType(to: Failure.self).eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
}
