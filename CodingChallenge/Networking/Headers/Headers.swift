enum Headers {
    case acceptJson
    case contentJson

    func getHeader() -> Header {
        switch self {
        case .acceptJson: return Header(key: "Accept", value: "application/json")
        case .contentJson: return Header(key: "Content-Type", value: "application/json")
        }
    }
}
