enum AcceptHeader: String, Header {
    case json = "application/json"

    var key: String { "Accept" }
    var value: String { rawValue }
}
