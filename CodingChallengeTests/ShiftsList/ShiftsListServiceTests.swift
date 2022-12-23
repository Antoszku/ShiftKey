import XCTest
@testable import CodingChallenge

final class ShiftsListServiceTests: XCTestCase {
    func test_getShifts_sendCorrectRequest() async {
        let expectedQueryParameters = ["type": "list",
                                       "address": "Cracow, PL",
                                       "radius": "10"]
        let apiClient = APIClientMock<String>()
        let sut = DefaultShiftsListService(apiClient: apiClient)
        let filter = ShiftFilter(type: .list, address: "Cracow, PL", radius: 10)

        _ = try? await sut.getShifts(filter: filter)

        let request = apiClient.sendRequestCalled
        XCTAssertEqual(request?.url, "/api/v2/available_shifts/")
        XCTAssertEqual(request?.method, .GET)
        XCTAssertEqual(request?.headers, [.acceptJson, .contentJson])
        XCTAssertEqual(request?.query?.parameters, expectedQueryParameters)
    }

    func test_getShifts_returnCorrectResult() async {
        let expectedResult = [ShiftsForDateDTO(date: "2020-12-12")]
        let apiClient = APIClientMock<ShiftsForDateResponseDTO>()
        let sut = DefaultShiftsListService(apiClient: apiClient)
        let filter = ShiftFilter(type: .list, address: "Cracow, PL", radius: 10)
        apiClient.returnResponse = .init(data: expectedResult)

        let result = try? await sut.getShifts(filter: filter)

        XCTAssertEqual(result, expectedResult)
    }
}

class APIClientMock<T: Decodable>: APIClient {

    var sendRequestCalled: Request?
    var returnResponse: T?

    func sendRequest<T>(_ request: Request) async throws -> T {
        sendRequestCalled = request
        guard let response = returnResponse as? T else { throw APIError.serverError(code: 0) }

        return response
    }
}
