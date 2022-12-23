import Foundation

struct Request {
    let url: URL
    let method: HTTPMethod
    let headers: [Header]
    let queryItems: [URLQueryItem]?

    init(url: URL,
         method: HTTPMethod,
         headers: [Header] = [AcceptHeader.json, ContentTypeHeader.json],
         queryItems: [URLQueryItem]? = nil)
    {
        self.url = url
        self.headers = headers
        self.method = method
        self.queryItems = queryItems
    }
}
