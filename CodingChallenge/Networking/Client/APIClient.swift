import Foundation

protocol APIClient {
    func sendRequest<T: Decodable>(request: Request) async throws -> T
}

class DefaultAPIClient: APIClient {

    private let session: SessionService

    init(session: SessionService = DefaultSessionService()) {
        self.session = session
    }

    func sendRequest<T: Decodable>(request: Request) async throws -> T {
        let urlRequest = makeURLRequest(request: request)
        print("[URL]: \(urlRequest.url?.description ?? "")")
        print("[HTTP Headers]: \(urlRequest.allHTTPHeaderFields?.description ?? "")")

        do {
            let (data, response) = try await session.data(for: urlRequest)
            guard let response = response as? HTTPURLResponse else { fatalError("Should never happen") }

            switch response.statusCode {
            case 200...299:
                print("[Response]:")
                printPrettyJson(for: data)
                guard let response = try? JSONDecoder().decode(T.self, from: data) else { throw APIError.parsingError }
                return response
            default:
                throw APIError.serverError(code: response.statusCode)
            }
        }
    }

    private func makeURLRequest(request: Request) -> URLRequest {
        var urlComponents = URLComponents(url: request.url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = request.queryItems

        guard let url = urlComponents?.url else { fatalError("Should never happen since Request type have URL type inside") }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        request.headers.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        return urlRequest
    }

    private func printPrettyJson(for data: Data) {
        guard let object = try? JSONSerialization.jsonObject(with: data, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedString = String(data: data, encoding: .utf8) else { return }

        print(prettyPrintedString)
    }
}
