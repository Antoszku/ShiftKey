import Foundation

struct Request {
    let url: String
    let method: HTTPMethod
    let headers: [Headers]
    let query: Query?

    init(url: String,
         method: HTTPMethod,
         headers: [Headers] = [.acceptJson, .contentJson],
         query: Query? = nil)
    {
        self.url = url
        self.headers = headers
        self.method = method
        self.query = query
    }
}
