enum ContentTypeHeader: String, Header {
    case json = "application/json"

    var key: String { "Content-Type" }
    var value: String { rawValue }
}

