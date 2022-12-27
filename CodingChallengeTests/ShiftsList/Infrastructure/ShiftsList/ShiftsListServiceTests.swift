import XCTest
@testable import CodingChallenge

final class ShiftsListServiceTests: XCTestCase {
    func test_getShifts_sendCorrectRequest() async {
        let expectedQueryParameters = ["type": "list",
                                       "address": "Cracow, PL",
                                       "radius": "150"]
        let apiClient = APIClientMock<String>()
        let sut = DefaultShiftsListService(apiClient: apiClient)
        let filter = ShiftFilter(type: .list, address: "Cracow, PL")
        
        _ = try? await sut.getShifts(filter: filter)
        
        let request = apiClient.sendRequestCalled
        XCTAssertEqual(request?.url, "/api/v2/available_shifts/")
        XCTAssertEqual(request?.method, .GET)
        XCTAssertEqual(request?.headers, [.acceptJson, .contentJson])
        XCTAssertEqual(request?.query?.parameters, expectedQueryParameters)
    }
    
    func test_getShifts_returnShiftForDateDTOArray() async {
        let date = Date(timeIntervalSince1970: 1_000_000)
        let dto = [ShiftsForDateDTO(date: date, shifts: [])]
        let expectedResult = [ShiftsForDate(date: date, shifts: [])]
        let apiClient = APIClientMock<ShiftsForDateResponseDTO>()
        let sut = DefaultShiftsListService(apiClient: apiClient)
        let filter = ShiftFilter(type: .list, address: "Cracow, PL")
        apiClient.returnResponse = .init(data: dto)
        
        let result = try? await sut.getShifts(filter: filter)
        
        XCTAssertEqual(result, expectedResult)
    }
}
