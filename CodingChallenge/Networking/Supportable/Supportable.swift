enum Supportable<T: Decodable & Equatable>: Decodable, Equatable {
    case supported(T)
    case unsupported

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            let value = try container.decode(T.self)
            self = .supported(value)
        } catch {
            // TODO: Send unsupported to analytics to track it
            print("🚨🚨🚨 Error while decoding enum \(T.self) \(error)")
            self = .unsupported
        }
    }
}

extension Supportable {
    static func == (lhs: Supportable<T>, rhs: Supportable<T>) -> Bool {
        switch (lhs, rhs) {

        case (.unsupported, .unsupported):
            return true
        case (.supported(let lhsValue), .supported(let rhsValue)):
            return lhsValue == rhsValue
        default:
            return false
        }
    }
}
