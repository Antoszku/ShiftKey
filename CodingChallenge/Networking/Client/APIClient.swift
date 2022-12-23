import Foundation

protocol APIClient {
    func sendRequest<T: Decodable>(_ request: Request) async throws -> T
}

final class DefaultAPIClient: APIClient {

    private let session: SessionService
    private let networkConfiguration: NetworkConfiguration

    init(session: SessionService = DefaultSessionService(),
         networkConfiguration: NetworkConfiguration = NetworkConfiguration()) {
        self.session = session
        self.networkConfiguration = networkConfiguration
    }

    func sendRequest<T: Decodable>(_ request: Request) async throws -> T {
        do {
            let urlRequest = try makeURLRequest(request: request)
            print("[URL]: \(urlRequest.url?.description ?? "")")
            print("[HTTP Headers]: \(urlRequest.allHTTPHeaderFields?.description ?? "")")

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

    private func makeURLRequest(request: Request) throws -> URLRequest {
        var urlComponents = URLComponents(string: request.url)
        urlComponents?.scheme = networkConfiguration.scheme
        urlComponents?.host = networkConfiguration.host
        if let query = request.query {
            urlComponents?.queryItems = makeQueryItems(for: query)
        }

        guard let url = urlComponents?.url else { fatalError("Should never happen since Request type have URL type inside") }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue

        request.headers.forEach {
            let header = $0.getHeader()
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }

        return urlRequest
    }

    func makeQueryItems(for query: Query) -> [URLQueryItem]? {
        query.parameters
            .filter { $0.value != nil }
            .map { URLQueryItem(name: $0.key, value: $0.value) }
    }

    private func printPrettyJson(for data: Data) {
        guard let object = try? JSONSerialization.jsonObject(with: data, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedString = String(data: data, encoding: .utf8) else { return }

        print(prettyPrintedString)
    }
}
