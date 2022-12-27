@testable import CodingChallenge

final class APIClientMock<T: Decodable>: APIClient {
    var sendRequestCalled: Request?
    var returnResponse: T?

    func sendRequest<T>(_ request: Request) async throws -> T {
        sendRequestCalled = request
        guard let response = returnResponse as? T else { throw APIError.serverError(code: 0) }

        return response
    }
}
