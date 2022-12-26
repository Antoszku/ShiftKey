enum Supportable<T: Decodable>: Decodable {
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
